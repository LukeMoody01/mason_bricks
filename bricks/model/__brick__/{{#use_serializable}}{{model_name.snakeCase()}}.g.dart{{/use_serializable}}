part of '{{model_name.snakeCase()}}.dart';

{{model_name.pascalCase()}} _${{model_name.pascalCase()}}FromJson(Map<String, dynamic> json) => {{model_name.pascalCase()}}({{#properties}}
      {{name}}: {{#isCustomList}}(json['{{name}}'] as List<dynamic>).map((dynamic e) => {{customListType}}.fromJson(e as Map<String, dynamic>)).toList(){{/isCustomList}}{{^isCustomList}}{{#isCustomDataType}}{{type}}.fromJson(json['{{name}}'] as Map<String, dynamic>){{/isCustomDataType}}{{^isCustomDataType}}json['{{name}}'] as {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}}{{/isCustomDataType}}{{/isCustomList}},{{/properties}}
    );

Map<String, dynamic> _${{model_name.pascalCase()}}ToJson({{model_name.pascalCase()}} instance) => <String, dynamic>{ {{#properties}}
      '{{name}}': instance.{{name}},{{/properties}}
    };