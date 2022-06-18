part of '{{service_name.snakeCase()}}.dart';

/// An interface for {{service_name.pascalCase()}}
abstract class I{{service_name.pascalCase()}}{ {{#methods}}
  /// A description for {{name}}
  FutureOr<{{{type}}}> {{name}}();
  {{/methods}}
}
