import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future<void> run(HookContext context) async {
  final usesFreezed = (context.vars['models'] as List)
          .where((element) => element['style'] == 'freezed')
          .length >
      0;
  final hasRelations = (context.vars['models'] as List)
          .where((element) => (element['relations'] as List? ?? []).isNotEmpty)
          .length >
      0;

  if (hasRelations || usesFreezed) await _validateDirectory(context);

  final logger = context.logger;
  final models = context.vars['models'];
  final generator = await MasonGenerator.fromBrick(
    Brick.version(name: 'model', version: '0.5.1'),
  );

  Map<String, dynamic> preGenVars = {};

  for (var model in models) {
    var progress = logger.progress('Creating ${model['model_name']}...');
    await generator.hooks.preGen(
      vars: {
        "model_name": model['model_name'],
        "additionals": model['additionals'],
        "style": model['style'],
        "properties": model['properties'],
        "relations": model['relations'],
      },
      onVarsChanged: (vars) => preGenVars = vars,
    );
    await generator.generate(
      DirectoryGeneratorTarget(Directory.current),
      vars: preGenVars,
      logger: context.logger,
    );
    progress.complete('Created ${model['model_name']}!');
  }
}

/// Checks to see if the current output directory is in the
/// lib folder.
/// Adds the fullPath to the current working directory
Future<void> _validateDirectory(HookContext context) async {
  final logger = context.logger;
  final directory = Directory.current.path;

  try {
    List<String> folders;

    if (Platform.isWindows) {
      folders = directory.split(r'\').toList();
    } else {
      folders = directory.split('/').toList();
    }
    final libIndex = folders.indexWhere((folder) => folder == 'lib');
    final modelPath = folders.sublist(libIndex + 1, folders.length).join('/');
    final pubSpecFile =
        File('${folders.sublist(0, libIndex).join('/')}/pubspec.yaml');
    final content = await pubSpecFile.readAsString();
    final yamlMap = loadYaml(content);
    final packageName = yamlMap['name'];
    context.vars = {
      ...context.vars,
      'fullPath': ('$packageName/$modelPath/').replaceAll('//', '/'),
    };
  } on RangeError catch (_) {
    logger.alert(
      red.wrap(
        'Could not find lib folder in $directory',
      ),
    );
    logger.alert(
      red.wrap(
        'Re-run this brick inside your lib folder',
      ),
    );
    throw Exception();
  } on FileSystemException catch (_) {
    logger.alert(
      red.wrap(
        'Could not find pubspec.yaml folder in ${directory.replaceAll('\\lib', '')}',
      ),
    );

    throw Exception();
  } on PubspecNameException catch (_) {
    logger.alert(
      red.wrap(
        'Could not read package name in pubspec.yaml',
      ),
    );
    logger.alert(
      red.wrap(
        'Does your pubspec have a name ?',
      ),
    );
    throw Exception();
  } on Exception catch (e) {
    throw e;
  }
}

class PubspecNameException implements Exception {}
