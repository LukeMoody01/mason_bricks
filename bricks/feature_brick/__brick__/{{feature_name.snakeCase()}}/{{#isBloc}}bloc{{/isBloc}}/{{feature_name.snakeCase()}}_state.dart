part of '{{feature_name.snakeCase()}}_bloc.dart';

class {{feature_name.pascalCase()}}State{{#use_equatable}} extends Equatable{{/use_equatable}} {
  const {{feature_name.pascalCase()}}State({
    this.customProperty = 'Default Value',
  });

  final String customProperty;
{{#use_equatable}}
  @override
  List<Object> get props => [customProperty];
{{/use_equatable}}
  {{feature_name.pascalCase()}}State copyWith({
    String? customProperty,
  }) {
    return {{feature_name.pascalCase()}}State(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

class {{feature_name.pascalCase()}}Initial extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}Initial() : super();
}
