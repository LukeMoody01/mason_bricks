import 'dart:async';

{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}
{{#use_freezed}}import 'package:{{packageName}}/{{feature_name.snakeCase()}}/bloc/{{feature_name.snakeCase()}}.dart';{{/use_freezed}}{{^use_freezed}}
part '{{feature_name.snakeCase()}}_event.dart';
part '{{feature_name.snakeCase()}}_state.dart'; {{/use_freezed}}

class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  {{feature_name.pascalCase()}}Bloc() : super(const {{feature_name.pascalCase()}}{{^use_freezed}}Initial(){{/use_freezed}}{{#use_freezed}}State.initial(id: ''){{/use_freezed}}) {
    on<Custom{{feature_name.pascalCase()}}Event>(_onCustom{{feature_name.pascalCase()}}Event);
  }

  FutureOr<void> _onCustom{{feature_name.pascalCase()}}Event(
    Custom{{feature_name.pascalCase()}}Event event,
    Emitter<{{feature_name.pascalCase()}}State> emit,
  ) {
    // TODO: Add Logic
  }
}
