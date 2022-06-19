import 'dart:async';

part 'i{{service_name.snakeCase()}}.dart';

/// {@template {{{service_name.snakeCase()}}}}
/// {{service_name.pascalCase()}} description
/// {@endtemplate}
class {{service_name.pascalCase()}} implements I{{service_name.pascalCase()}} { {{#isNone}}
  /// {@macro {{{service_name.snakeCase()}}}}
  const {{service_name.pascalCase()}}();{{/isNone}}{{#isFactory}}
  /// {@macro {{{service_name.snakeCase()}}}}
  factory {{service_name.pascalCase()}}() {
    return _instance;
  }

  const {{service_name.pascalCase()}}._();
  static const {{service_name.pascalCase()}} _instance = {{service_name.pascalCase()}}._();{{/isFactory}}{{#isInstance}}
  const {{service_name.pascalCase()}}._();
  /// {@macro {{{service_name.snakeCase()}}}}
  static const {{service_name.pascalCase()}} instance = const {{service_name.pascalCase()}}._();{{/isInstance}}{{#isInstanceLazy}}
  const {{service_name.pascalCase()}}._();
  static {{service_name.pascalCase()}}? _instance;
  /// {@macro {{{service_name.snakeCase()}}}}
  static {{service_name.pascalCase()}} get instance => _instance ??= const {{service_name.pascalCase()}}._();{{/isInstanceLazy}}
{{#methods}}
  @override
  FutureOr<{{{type}}}> {{name}}() async {
    //TODO: Add Logic
    return Future.value();
  }
{{/methods}}
}
