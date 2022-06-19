part of '{{feature_name.snakeCase()}}_cubit.dart';

/// {@template {{{feature_name.snakeCase()}}}}
/// {{feature_name.pascalCase()}}State description
/// {@endtemplate}
class {{feature_name.pascalCase()}}State{{#use_equatable}} extends Equatable{{/use_equatable}} {
  /// {@macro {{{feature_name.snakeCase()}}}}
  const {{feature_name.pascalCase()}}State({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;
{{#use_equatable}}
  @override
  List<Object> get props => [customProperty];
{{/use_equatable}}
  /// Creates a copy of the current {{feature_name.pascalCase()}}State with property changes
  {{feature_name.pascalCase()}}State copyWith({
    String? customProperty,
  }) {
    return {{feature_name.pascalCase()}}State(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}
/// {@template {{feature_name.snakeCase()}}_initial}
/// The initial state of {{feature_name.pascalCase()}}State
/// {@endtemplate}
class {{feature_name.pascalCase()}}Initial extends {{feature_name.pascalCase()}}State {
  /// {@macro {{feature_name.snakeCase()}}_initial}
  const {{feature_name.pascalCase()}}Initial() : super();
}
