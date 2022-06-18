{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_json}}

part '{{model_name.snakeCase()}}.g.dart';{{/use_json}}

/// {@template {{{model_name.snakeCase()}}}}
/// {{model_name.pascalCase()}} description
/// {@endtemplate}
class {{model_name.pascalCase()}}{{#use_equatable}} extends Equatable{{/use_equatable}} {
  /// {@macro {{{model_name.snakeCase()}}}}
  const {{model_name.pascalCase()}}({{#hasProperties}}{ {{#properties}}
    required this.{{name}},{{/properties}}
  }{{/hasProperties}});{{#use_json}}

  /// Creates a {{model_name.pascalCase()}} from Json map
  factory {{model_name.pascalCase()}}.fromJson(Map<String, dynamic> data) => _${{model_name.pascalCase()}}FromJson(data);{{/use_json}}
{{#properties}}
  /// A description for {{name}}
  final {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}} {{name}};{{/properties}}
{{#use_copywith}}
  /// Creates a copy of the current {{model_name.pascalCase()}} with property changes
  {{model_name.pascalCase()}} copyWith({{#hasProperties}}{ {{#properties}}
    {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}}? {{name}},{{/properties}}
  }{{/hasProperties}}) {
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
  /// Creates a Json map from a {{model_name.pascalCase()}}
  Map<String, dynamic> toJson() => _${{model_name.pascalCase()}}ToJson(this);{{/use_json}}
}
