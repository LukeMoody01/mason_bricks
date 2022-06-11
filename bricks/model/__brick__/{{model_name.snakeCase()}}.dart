{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_json}}

part '{{model_name.snakeCase()}}.g.dart';{{/use_json}}

class {{model_name.pascalCase()}}{{#use_equatable}} extends Equatable{{/use_equatable}} {
  const {{model_name.pascalCase()}}({{#hasProperty1}}
    this.{{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
    this.{{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
    this.{{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
    this.{{property4Name}},{{/hasProperty4}}
  );
{{#hasProperty1}}
  final {{property1Type}} {{property1Name}};{{/hasProperty1}}{{#hasProperty2}}
  final {{property2Type}} {{property2Name}};{{/hasProperty2}}{{#hasProperty3}}
  final {{property3Type}} {{property3Name}};{{/hasProperty3}}{{#hasProperty4}}
  final {{property4Type}} {{property4Name}};{{/hasProperty4}}
{{#use_copywith}}
  {{model_name.pascalCase()}} copyWith({{#hasProperty1}} {
  {{property1Type}}? {{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
  {{property2Type}}? {{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
  {{property3Type}}? {{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
  {{property4Type}}? {{property4Name}},{{/hasProperty4}}
  {{#hasProperty1}} }{{/hasProperty1}}) {
    return {{model_name.pascalCase()}}({{#hasProperty1}}
    {{property1Name}} ?? this.{{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
    {{property2Name}} ?? this.{{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
    {{property3Name}} ?? this.{{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
    {{property4Name}} ?? this.{{property4Name}},{{/hasProperty4}}
    );
  }{{/use_copywith}}{{#use_equatable}}
  @override
  List<Object?> get props => [{{#hasProperty1}}
    {{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
    {{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
    {{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
    {{property4Name}},{{/hasProperty4}}
    ];
{{/use_equatable}}{{#use_json}}
  factory {{model_name.pascalCase()}}.fromJson(Map<String, dynamic> data) =>
      _${{model_name.pascalCase()}}FromJson(data);
  Map<String, dynamic> toJson() => _${{model_name.pascalCase()}}ToJson(this);{{/use_json}}
}
