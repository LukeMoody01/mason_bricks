import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;
  final isAddingProperties =
      logger.confirm('? Do you want to add properties?', defaultValue: true);
  var propertyIndex = 1;
  if (isAddingProperties) {
    logger.alert(
        'Format: {propertyName}/{type} eg. id/String, enter "e" to exit adding properties:');
    while (propertyIndex < 16) {
      final response = logger.prompt(':');
      if (response.toLowerCase() == 'e') break;

      final splitProperty = response.split('/');
      final propertyName = splitProperty[0];
      final propertyType = splitProperty[1];
      context.vars = {
        ...context.vars,
        'property${propertyIndex}Name': propertyName,
        'property${propertyIndex}Type': propertyType,
        'hasProperty${propertyIndex}': true,
      };
      propertyIndex++;
      if (propertyIndex >= 16)
        logger.alert('You have reached the maximum number of properties (15)');
    }
  }
}
