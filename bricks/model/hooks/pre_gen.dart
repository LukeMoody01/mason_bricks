import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;
  final isAddingProperties =
      logger.confirm('? Do you want to add properties?', defaultValue: true);
  if (isAddingProperties) {
    logger.alert(
        'Format: {propertyName}/{type} eg. id/String, enter "e" to exit adding properties:');
    final properties = {"properties": []};
    while (true) {
      final response = logger.prompt(':');
      if (response.toLowerCase() == 'e') break;
      if (!response.contains('/')) {
        logger.alert(
            'That was not a valid format -> {propertyName}/{type} eg. id/String');
        continue;
      }
      final splitProperty = response.split('/');
      final propertyName = splitProperty[0];
      final propertyType = splitProperty[1];
      properties['properties']!.add({
        'name': propertyName,
        'type': propertyType,
        'isList': propertyType.toLowerCase().contains('list')
      });
      context.vars = {
        ...context.vars,
        properties.entries.first.key: properties.values.first,
      };
    }
  }
}
