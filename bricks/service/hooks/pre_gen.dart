import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;

  final singletonType = context.vars['singleton_type'].toString().toLowerCase();
  final isFactory = singletonType == 'factory-singleton';
  final isInstance = singletonType == 'static-instance-singleton';
  final isInstanceLazy = singletonType == 'static-instance-lazy-singleton';
  final isNone = singletonType == 'none';

  context.vars = {
    ...context.vars,
    'isFactory': isFactory,
    'isInstance': isInstance,
    'isInstanceLazy': isInstanceLazy,
    'isNone': isNone,
  };

  if (!logger.confirm('? Do you want to add methods?', defaultValue: true)) {
    return;
  }

  logger.alert(
      'Format: {returnType}/{methodName} eg. String/myMethod, enter "e" to exit adding properties:');
  final methods = <Map<String, dynamic>>[];

  while (true) {
    final property = logger.prompt(':');
    if (property.toLowerCase() == 'e') {
      break;
    }

    if (!property.contains('/')) {
      logger.alert(
          'That was not a valid format -> {returnType}/{methodName} eg. String/myMethod');
      continue;
    }

    final splitProperty = property.split('/');
    final propertyType = splitProperty[0];
    final propertyName = splitProperty[1];
    methods.add({
      'name': propertyName,
      'type': propertyType,
    });
  }
  context.vars = {
    ...context.vars,
    'methods': methods,
  };
}
