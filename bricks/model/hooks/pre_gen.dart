import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;

  if (!logger.confirm('? Do you want to add properties?', defaultValue: true)) {
    return;
  }

  logger.alert(
      'Format: {propertyName}/{type} eg. id/String, enter "e" to exit adding properties:');
  final properties = <Map<String, dynamic>>[];

  while (true) {
    final response = logger.prompt(':');
    if (response.toLowerCase() == 'e') {
      break;
    }

    if (!response.contains('/')) {
      logger.alert(
          'That was not a valid format -> {propertyName}/{type} eg. id/String');
      continue;
    }

    final splitProperty = response.split('/');
    final propertyName = splitProperty[0];
    final propertyType = splitProperty[1];
    properties.add({
      'name': propertyName,
      'type': propertyType,
      'hasSpecial': propertyType.toLowerCase().contains('<') ||
          propertyType.toLowerCase().contains('>')
    });
    context.vars = {
      ...context.vars,
      'properties': properties,
    };
  }
}
