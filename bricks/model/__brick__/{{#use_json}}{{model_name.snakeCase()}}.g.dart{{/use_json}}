part of '{{model_name.snakeCase()}}.dart';

{{model_name.pascalCase()}} _${{model_name.pascalCase()}}FromJson(Map<String, dynamic> json) => {{model_name.pascalCase()}}({{#properties}}
      {{name}}: {{#isCustomDataType}}{{type}}.fromJson(json['{{name}}'] as Map<String, dynamic>){{/isCustomDataType}}{{^isCustomDataType}}json['{{name}}'] as {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}}{{/isCustomDataType}},{{/properties}}
    );

Map<String, dynamic> _${{model_name.pascalCase()}}ToJson({{model_name.pascalCase()}} instance) => <String, dynamic>{ {{#properties}}
      '{{name}}': instance.{{name}},{{/properties}}
    };