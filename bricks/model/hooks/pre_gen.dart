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
    return;
  }

  logger.alert(
      'Format: {propertyName}/{dataType} eg. id/String, enter "e" to exit adding properties:');
  final properties = <Map<String, dynamic>>[];

  while (true) {
    final response = logger.prompt(':');
    if (response.toLowerCase() == 'e') {
      break;
    }

    if (!response.contains('/')) {
      logger.alert(
          'That was not a valid format -> {propertyName}/{dataType} eg. id/String');
      continue;
    }

    final splitProperty = response.split('/');
    final propertyName = splitProperty[0];
    final propertyType = splitProperty[1];
    final hasSpecial = propertyType.toLowerCase().contains('<') ||
        propertyType.toLowerCase().contains('>');
    final isCustomDataType = !dataTypes.contains(propertyType) &&
        !hasSpecial; //TODO(Allow List<CustomType>)
    properties.add({
      'name': propertyName,
      'type': propertyType,
      'hasSpecial': hasSpecial,
      'isCustomDataType': isCustomDataType
    });
    context.vars = {
      ...context.vars,
      'properties': properties,
    };
  }
}
