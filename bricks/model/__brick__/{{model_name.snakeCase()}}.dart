{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_json}}

part '{{model_name.snakeCase()}}.g.dart';{{/use_json}}

class {{model_name.pascalCase()}}{{#use_equatable}} extends Equatable{{/use_equatable}} {
  const {{model_name.pascalCase()}}({ {{#properties}}
  required this.{{name}},{{/properties}}
  });
{{#properties}}
  final {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}} {{name}};{{/properties}}

{{#use_copywith}}
  {{model_name.pascalCase()}} copyWith({ {{#properties}}
    {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}}? {{name}},{{/properties}}
  }) {
    return {{model_name.pascalCase()}}({{#properties}}
      {{name}}: {{name}} ?? this.{{name}},{{/properties}}
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
