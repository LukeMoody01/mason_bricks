{{^use_freezed}}part of '{{feature_name.snakeCase()}}_bloc.dart';

/// {@template {{feature_name.snakeCase()}}_state}
/// {{feature_name.pascalCase()}}State description
/// {@endtemplate}
class {{feature_name.pascalCase()}}State{{#use_equatable}} extends Equatable{{/use_equatable}} {
  /// {@macro {{feature_name.snakeCase()}}_state}
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
}{{/use_freezed}}{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_state.freezed.dart';

@freezed
class {{feature_name.pascalCase()}}State with _${{feature_name.pascalCase()}}State {
  const factory {{feature_name.pascalCase()}}State.initial({
    required String id,
    @Default(0) int num,
  }) = {{feature_name.pascalCase()}}Initial;
}{{/use_freezed}}
