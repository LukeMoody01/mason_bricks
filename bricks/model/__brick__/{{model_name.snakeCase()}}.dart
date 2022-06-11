{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_json}}

part '{{model_name.snakeCase()}}.g.dart';{{/use_json}}

class {{model_name.pascalCase()}}{{#use_equatable}} extends Equatable{{/use_equatable}} {
  const {{model_name.pascalCase()}}({{#properties}}
  this.{{name}},{{/properties}}
  );
{{#properties}}
  final {{#isList}}{{{type}}}{{/isList}}{{^isList}}{{type}}{{/isList}} {{name}};{{/properties}}

{{#use_copywith}}
  {{model_name.pascalCase()}} copyWith({ {{#properties}}
    {{#isList}}{{{type}}}{{/isList}}{{^isList}}{{type}}{{/isList}}? {{name}},{{/properties}}
  }) {
    return {{model_name.pascalCase()}}({{#properties}}
      {{name}} ?? this.{{name}},{{/properties}}
    );
  }{{/use_copywith}}
  {{#use_equatable}}
  @override
  List<Object?> get props => [{{#properties}}
        {{name}},{{/properties}}
      ];
{{/use_equatable}}{{#use_json}}
  factory {{model_name.pascalCase()}}.fromJson(Map<String, dynamic> data) => _${{model_name.pascalCase()}}FromJson(data);
  Map<String, dynamic> toJson() => _${{model_name.pascalCase()}}ToJson(this);{{/use_json}}
}
