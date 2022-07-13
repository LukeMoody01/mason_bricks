{{^use_freezed}}part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}Event {
  const {{feature_name.pascalCase()}}Event();
}

/// {@template custom_{{feature_name.snakeCase()}}_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class Custom{{feature_name.pascalCase()}}Event extends {{feature_name.pascalCase()}}Event {}{{/use_freezed}}{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_event.freezed.dart';

@freezed
class {{feature_name.pascalCase()}}Event with _${{feature_name.pascalCase()}}Event {
  const factory {{feature_name.pascalCase()}}Event.event() = Custom{{feature_name.pascalCase()}}Event;
}{{/use_freezed}}
