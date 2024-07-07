// ignore_for_file: lines_longer_than_80_chars, avoid_catching_errors

import 'dart:io';

import 'package:mason/mason.dart';

import 'json_handler/model_generator.dart';
import 'json_handler/syntax.dart';
import 'model_service.dart';
import 'property.dart';
import 'recase.dart';

Future<void> run(HookContext context) async {
  final logger = context.logger;
  final additionals = context.vars['additionals'] as List<dynamic>;
  final modelStyle = context.vars['style'] as String;
  var hasRelations = context.vars['relations'] != null &&
      (context.vars['relations'] as List).isNotEmpty;
  context.vars = {
    ...context.vars,
    'hasRelations': hasRelations,
    'use_copywith': additionals.contains('copyWith'),
    'use_json': additionals.contains('json'),
    'use_equatable': additionals.contains('equatable'),
    'use_tostring': additionals.contains('toString'),
    'use_none': modelStyle == 'basic',
    'use_serializable': modelStyle == 'json_serializable',
    'use_freezed': modelStyle == 'freezed',
    'use_hive': modelStyle == 'hive',
    'jsonIndex': ((context.vars['jsonIndex'] as int?) ?? 0),
  };

  final jsonFile = File(context.vars['jsonFile']);
  final jsonIndex = context.vars['jsonIndex'] as int;

  /// Check for json file
  if (jsonFile.existsSync()) {
    context.vars = {
      ...context.vars,
      'json': jsonFile.readAsStringSync(),
    };
  }

  /// If there is seeded-json, then handle json
  if (context.vars['json'] is String &&
      (context.vars['json'] as String).isNotEmpty) {
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
      'relations': (classToParse?.dependencies ?? [])
          .map((e) => {'name': ReCase(e.name).snakeCase})
          .toList(),
      'model_name': (classToParse?.name ?? context.vars['model_name']),
      'properties': propertiesFromJson,
      'hasRelations': (classToParse?.dependencies.isNotEmpty == true),
    };

    hasRelations = (classToParse?.dependencies.isNotEmpty == true);
  }

  final hasSeededProperties = context.vars['properties'] != null &&
      (context.vars['properties'] as List).isNotEmpty;

  // For freezed check:
  // As the post_gen has the option to run build_runner, we make this check
  // beforehand to make sure we are in the lib directory.
  //
  // For relations check:
  // As relations requires the lib directory, we make this check
  // beforehand to make sure we are in the lib directory.
  if (modelStyle == 'freezed' || hasRelations) {
    final progress = logger.progress('Validating output directory');
    await ModelService.validateDirectory(context);
    progress.complete('Valid output directory!');
  }

  final properties = <Map<String, dynamic>>[];

  if (hasSeededProperties) {
    final seededProperties = context.vars['properties'] as List;
    ModelService.verifySeededProperties(seededProperties, logger);
    for (final property in seededProperties) {
      ModelService.addProperty(
        properties,
        Property.fromMap(property as Map<String, dynamic>),
      );
    }
  } else if (logger.confirm(
    '? Do you want to add properties to your model?',
    defaultValue: true,
  )) {
    ModelService.addProperties(logger, properties);
  }

  context.vars = {
    ...context.vars,
    'properties': properties,
    'hasProperties': properties.isNotEmpty,
  };
}

Future<void> preGenHookWrapper(HookContext context,
    {Function(Map<String, dynamic> value)? preGenHookChanged}) async {
  await run(context);
  preGenHookChanged?.call(context.vars);
}
