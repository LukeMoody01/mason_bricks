import 'dart:io';

import 'package:mason/mason.dart';

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

void run(HookContext context) {
  final logger = context.logger;
  final additionals = context.vars['additionals'];
  final model_style = context.vars['style'] as String;
  final vars = {
    ...context.vars,
    'use_copywith': additionals.contains('copyWith'),
    'use_json': additionals.contains('json'),
    'use_equatable': additionals.contains('equatable'),
    'use_none': model_style == 'basic',
    'use_serializable': model_style == 'json_serializable',
    'use_freezed': model_style == 'freezed',
  };

  // As the post_gen has the option to run build_runner, we make this check
  // beforehand to make sure we are in the lib directory
  if (model_style == 'freezed') {
    final directory = Directory.current.path;
    List<String> folders;

    if (Platform.isWindows) {
      folders = directory.split(r'\').toList();
    } else {
      folders = directory.split('/').toList();
    }
    final libIndex = folders.indexWhere((folder) => folder == 'lib');

    if (libIndex == -1) {
      throw Exception(
          'If you are using freezed, the output directory should be inside the lib folder.');
    }
  }

  if (!logger.confirm(
    '? Do you want to add properties to your model?',
    defaultValue: true,
  )) {
    context.vars = {
      ...vars,
      'hasProperties': false,
    };
    return;
  }

  logger.alert(lightYellow.wrap('enter "e" to exit adding properties'));
  logger.alert('Format: dataType propertyName e.g, String myProperty:');
  final properties = <Map<String, dynamic>>[];

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
    final hasSpecial = propertyType.toLowerCase().contains('<') ||
        propertyType.toLowerCase().contains('>');
    final listProperties = _getCustomListProperties(hasSpecial, propertyType);
    final isCustomDataType = !dataTypes.contains(propertyType) && !hasSpecial;
    properties.add({
      'name': propertyName,
      'type': propertyType,
      'hasSpecial': hasSpecial,
      'isCustomDataType': isCustomDataType,
      ...listProperties,
    });
  }
  context.vars = {
    ...vars,
    'properties': properties,
    'hasProperties': properties.isNotEmpty,
  };
}

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
