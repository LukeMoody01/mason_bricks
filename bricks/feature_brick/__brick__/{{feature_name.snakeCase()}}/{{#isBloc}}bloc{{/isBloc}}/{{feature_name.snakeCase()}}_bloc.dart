import 'dart:async';

import 'package:bloc/bloc.dart';{{#use_equatable}}
import 'package:equatable/equatable.dart';{{/use_equatable}}
part '{{feature_name.snakeCase()}}_event.dart';
part '{{feature_name.snakeCase()}}_state.dart';

class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  {{feature_name.pascalCase()}}Bloc() : super(const {{feature_name.pascalCase()}}Initial()) {
    on<Custom{{feature_name.pascalCase()}}Event>(_onCustom{{feature_name.pascalCase()}}Event);
  }

  FutureOr<void> _onCustom{{feature_name.pascalCase()}}Event(
    Custom{{feature_name.pascalCase()}}Event event,
    Emitter<{{feature_name.pascalCase()}}State> emit,
  ) {
    // TODO: Add Logic
  }
}
