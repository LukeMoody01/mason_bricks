import 'dart:io';

import 'package:mason/mason.dart';
import 'json_handler/model_generator.dart';
import 'json_handler/syntax.dart';
import 'model_bundle.dart';
import 'recase.dart';
import 'pre_gen.dart' as pre_gen;

Future<void> run(HookContext context) async {
  final usesFreezed = context.vars['use_freezed'] as bool;
  final logger = context.logger;
  final directory = Directory.current.path;
  List<String> folders;

  if (Platform.isWindows) {
    folders = directory.split(r'\').toList();
  } else {
    folders = directory.split('/').toList();
  }

  final hasJson = context.vars['json'] != null &&
      context.vars['json'] is String &&
      (context.vars['json'] as String).isNotEmpty;

  if (hasJson) {
    final jsonIndex = (context.vars['jsonIndex'] as int) + 1;
    final classes = ModelGenerator(context.vars['model_name'])
        .generateClassDefinitions(context.vars['json'] as String);

    final classToParse =
        classes.length - 1 >= jsonIndex ? classes[jsonIndex] : null;
    final classFieldsToParse = classToParse != null
        ? classes[jsonIndex].fields
        : <String, TypeDefinition>{};

    final propertiesFromJson = <Map<String, dynamic>>[
      ...classFieldsToParse.keys.map(
        (e) {
          final value = classFieldsToParse.entries
              .firstWhere((element) => element.key == e)
              .value;
          final type =
              '''${value.name}${(value.subtype != null) ? '<${value.subtype}>' : ''}''';
          return {
            'name': e,
            'type': type,
          };
        },
      )
    ];

    context.vars = {
      ...context.vars,
      'properties': propertiesFromJson,
      'jsonIndex': jsonIndex,
    };

    if (propertiesFromJson.isNotEmpty && classFieldsToParse.isNotEmpty) {
      final modelTestGen = await MasonGenerator.fromBundle(modelBundle);

      var filteredVars = {
        'model_name': context.vars['model_name'],
        'additionals': context.vars['additionals'],
        'style': context.vars['style'],
        'jsonIndex': jsonIndex,
        'relations': classToParse != null
            ? [
                ...classToParse.dependencies
                    .map((e) => {'name': ReCase(e.name).snakeCase})
              ]
            : null,
        'json': '${context.vars['json']}',
        'jsonFile': ''
      };

      await pre_gen.run(
        context..vars = filteredVars,
      );

      await modelTestGen.generate(
        DirectoryGeneratorTarget(
          Directory(('${folders.join('/')}')),
        ),
        vars: context.vars,
        logger: logger,
      );

      if (classes.length - 1 != jsonIndex) {
        await run(context);
      } else if (usesFreezed &&
          logger.confirm('Would you like to generate the freezed model?',
              defaultValue: true)) {
        final libIndex = folders.indexWhere((folder) => folder == 'lib');
        final root = folders.sublist(0, libIndex).join('/').toString();
        final buildRunnerProcess = await Process.start(
          'flutter',
          [
            'pub',
            'run',
            'build_runner',
            'build',
            '--delete-conflicting-outputs'
          ],
          runInShell: true,
          workingDirectory: root,
        );
        await stdout.addStream(buildRunnerProcess.stdout);
        await stderr.addStream(buildRunnerProcess.stderr);
      }
    }
  }
}
