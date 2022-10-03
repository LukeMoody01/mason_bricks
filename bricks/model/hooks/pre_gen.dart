import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

final dataTypes = [
  'String',
  'num',
  'int',
  'double',
  'bool',
  'List',
  'Map',
  'dynamic',
  'Set',
  'DateTime',
];

Future<void> run(HookContext context) async {
  final logger = context.logger;
  final additionals = context.vars['additionals'];
  final model_style = context.vars['style'] as String;
  final hasRelations = (context.vars["relations"] != null &&
      (context.vars['relations'] as List).isNotEmpty);
  context.vars = {
    ...context.vars,
    'hasRelations': hasRelations,
    'use_copywith': additionals.contains('copyWith'),
    'use_json': additionals.contains('json'),
    'use_equatable': additionals.contains('equatable'),
    'use_none': model_style == 'basic',
    'use_serializable': model_style == 'json_serializable',
    'use_freezed': model_style == 'freezed',
  };

  final hasSeededProperties = (context.vars['properties'] != null &&
      (context.vars['properties'] as List).isNotEmpty);

  // For freezed check:
  // As the post_gen has the option to run build_runner, we make this check
  // beforehand to make sure we are in the lib directory.
  //
  // For relations check:
  // As relations requires the lib directory, we make this check
  // beforehand to make sure we are in the lib directory.
  if (model_style == 'freezed' || hasRelations) {
    final progress = logger.progress('Validating output directory');
    await _validateDirectory(context);
    progress.complete('Valid output directory!');
  }

  final properties = <Map<String, dynamic>>[];

  if (hasSeededProperties) {
    final seededProperties = context.vars['properties'] as List;
    _verifySeededProperties(seededProperties, logger);
    for (final property in seededProperties) {
      _addProperty(
        properties,
        Property(
          name: property['name'],
          type: property['type'],
        ),
      );
    }
  } else if (logger.confirm(
    '? Do you want to add properties to your model?',
    defaultValue: true,
  )) {
    _addProperties(logger, properties);
  }

  context.vars = {
    ...context.vars,
    'properties': properties,
    'hasProperties': properties.isNotEmpty,
  };
}

/// Verifies if the seeded properties / config is acceptable
void _verifySeededProperties(List seededProperties, Logger logger) {
  for (var property in seededProperties) {
    try {
      // This will throw an exception if we cannot decode the json
      Property.fromJson(jsonEncode(property));
    } catch (e) {
      logger.err('''Could not parse property: ${property.toString()}
Please check the variable names of your properties. It should be along the lines of:
{ "name": "firstName", "type": "String" }
''');
      exit(0);
    }
  }
}

/// Adds properties to the model until the user escapes by entering `e`.
void _addProperties(Logger logger, List<Map<String, dynamic>> properties) {
  logger.info(lightYellow.wrap('enter `e` to exit adding properties'));
  logger.info(lightYellow
      .wrap('Format: dataType propertyName e.g, String myProperty:'));

  while (true) {
    final property = logger.prompt(':').replaceAll(RegExp('\\s+'), ' ').trim();
    if (property.toLowerCase() == 'e') {
      break;
    }

    if (!property.contains(' ')) {
      logger.alert(
          'That was not a valid format -> dataType propertyName e.g, String myProperty');
      continue;
    }

    if ((property.contains('<') && !property.contains('>')) ||
        (property.contains('>') && !property.contains('<'))) {
      logger.alert(
          'It seems you are missing a < or >, please retype this property');
      continue;
    }

    final splitProperty = property.split(' ');
    final propertyType = splitProperty[0];
    final propertyName = splitProperty[1];
    _addProperty(properties, Property(name: propertyName, type: propertyType));
  }
}

/// Adds a property to the [properties] list.
void _addProperty(
  List<Map<String, dynamic>> properties,
  Property property,
) {
  final hasSpecial = property.type.toLowerCase().contains('<') ||
      property.type.toLowerCase().contains('>');
  final listProperties = _getCustomListProperties(hasSpecial, property.type);
  final isCustomDataType = !dataTypes.contains(property.type) && !hasSpecial;
  properties.add({
    'name': property.name,
    'type': property.type,
    'hasSpecial': hasSpecial,
    'isCustomDataType': isCustomDataType,
    ...listProperties,
  });
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

/// Checks to see if the property type is special.
///
/// This check is required due to the mustache syntax:
/// All variables are HTML escaped by default. If you want
/// to return unescaped HTML, use the triple mustache: {{{name}}}.
///
/// returns a [Map<String, dynamic>] containing the properties variables
Map<String, dynamic> _getCustomListProperties(
  bool hasSpecial,
  String propertyType,
) {
  if (!hasSpecial || !propertyType.contains('List')) {
    return {
      'isCustomList': false,
    };
  }
  final startIndex = propertyType.indexOf('<');
  final endIndex = propertyType.indexOf('>');
  final listType = propertyType.substring(startIndex + 1, endIndex).trim();
  if (dataTypes.contains(listType)) {
    return {
      'isCustomList': false,
    };
  }
  return {
    'isCustomList': true,
    'customListType': listType,
  };
}

class Property {
  const Property({
    required this.name,
    required this.type,
  });

  final String name;
  final String type;

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      name: map['name'],
      type: map['type'],
    );
  }

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source));
}

class PubspecNameException implements Exception {}
