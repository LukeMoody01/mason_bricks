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
];

void run(HookContext context) {
  final logger = context.logger;

  if (!logger.confirm('? Do you want to add properties?', defaultValue: true)) {
    context.vars = {
      ...context.vars,
      'hasProperties': false,
    };
    return;
  }

  logger.alert(
      'Format: {dataType}/{propertyName} eg. String/id, enter "e" to exit adding properties:');
  final properties = <Map<String, dynamic>>[];

  while (true) {
    final property = logger.prompt(':');
    if (property.toLowerCase() == 'e') {
      break;
    }

    if (!property.contains('/')) {
      logger.alert(
          'That was not a valid format -> {dataType}/{propertyName} eg. String/id');
      continue;
    }

    if ((property.contains('<') && !property.contains('>')) ||
        (property.contains('>') && !property.contains('<'))) {
      logger.alert(
          'It seems you are missing a < or >, please retype this property');
      continue;
    }

    final splitProperty = property.split('/');
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
    ...context.vars,
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
