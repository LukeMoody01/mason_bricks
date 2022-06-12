part of '{{service_name.snakeCase()}}.dart';

/// A description for {{service_name}}
abstract class I{{service_name.pascalCase()}}{ {{#methods}}
  /// A description for {{name}}
  FutureOr<{{{type}}}> {{name}}();
  {{/methods}}
}
