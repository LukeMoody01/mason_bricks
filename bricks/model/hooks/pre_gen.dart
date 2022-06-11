import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;
  var isAddingProperties =
      logger.confirm('? Do you want to add properties?', defaultValue: true);
  var propertyCount = 1;
  if (isAddingProperties) {
    logger.alert(
        'Format: {propertyName}/{type} eg. id/String, enter "e" to exit adding properties:');
    while (isAddingProperties && propertyCount < 11) {
      final response = logger.prompt(':');
      if (response.toLowerCase() == 'e') break;

      final splitProperty = response.split('/');
      final propertyName = splitProperty[0];
      final propertyType = splitProperty[1];
      context.vars = {
        ...context.vars,
        'property${propertyCount}Name': propertyName,
        'property${propertyCount}Type': propertyType,
        'hasProperty${propertyCount}': true,
      };
      propertyCount++;
    }
  }
}
