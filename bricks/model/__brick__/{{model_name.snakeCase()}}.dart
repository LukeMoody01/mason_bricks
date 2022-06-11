{{#use_equatable}}import 'package:equatable/equatable.dart';{{/use_equatable}}{{#use_json}}

part '{{model_name.snakeCase()}}.g.dart';{{/use_json}}

class {{model_name.pascalCase()}}{{#use_equatable}} extends Equatable{{/use_equatable}} {
  const {{model_name.pascalCase()}}({{#hasProperty1}}
    this.{{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
    this.{{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
    this.{{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
    this.{{property4Name}},{{/hasProperty4}}{{#hasProperty5}}
    this.{{property5Name}},{{/hasProperty5}}{{#hasProperty6}}
    this.{{property6Name}},{{/hasProperty6}}{{#hasProperty7}}
    this.{{property7Name}},{{/hasProperty7}}{{#hasProperty8}}
    this.{{property8Name}},{{/hasProperty8}}{{#hasProperty9}}
    this.{{property9Name}},{{/hasProperty9}}{{#hasProperty10}}
    this.{{property10Name}},{{/hasProperty10}}{{#hasProperty11}}
    this.{{property11Name}},{{/hasProperty11}}{{#hasProperty12}}
    this.{{property12Name}},{{/hasProperty12}}{{#hasProperty13}}
    this.{{property13Name}},{{/hasProperty13}}{{#hasProperty14}}
    this.{{property14Name}},{{/hasProperty14}}{{#hasProperty15}}
    this.{{property15Name}},{{/hasProperty15}}
  );
{{#hasProperty1}}
  final {{property1Type}} {{property1Name}};{{/hasProperty1}}{{#hasProperty2}}
  final {{property2Type}} {{property2Name}};{{/hasProperty2}}{{#hasProperty3}}
  final {{property3Type}} {{property3Name}};{{/hasProperty3}}{{#hasProperty4}}
  final {{property4Type}} {{property4Name}};{{/hasProperty4}}{{#hasProperty5}}
  final {{property5Type}} {{property5Name}};{{/hasProperty5}}{{#hasProperty6}}
  final {{property6Type}} {{property6Name}};{{/hasProperty6}}{{#hasProperty7}}
  final {{property7Type}} {{property7Name}};{{/hasProperty7}}{{#hasProperty8}}
  final {{property8Type}} {{property8Name}};{{/hasProperty8}}{{#hasProperty9}}
  final {{property9Type}} {{property9Name}};{{/hasProperty9}}{{#hasProperty10}}
  final {{property10Type}} {{property10Name}};{{/hasProperty10}}{{#hasProperty11}}
  final {{property11Type}} {{property11Name}};{{/hasProperty11}}{{#hasProperty12}}
  final {{property12Type}} {{property12Name}};{{/hasProperty12}}{{#hasProperty13}}
  final {{property13Type}} {{property13Name}};{{/hasProperty13}}{{#hasProperty14}}
  final {{property14Type}} {{property14Name}};{{/hasProperty14}}{{#hasProperty15}}
  final {{property15Type}} {{property15Name}};{{/hasProperty15}}
{{#use_copywith}}
  {{model_name.pascalCase()}} copyWith({{#hasProperty1}} {
    {{property1Type}}? {{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
    {{property2Type}}? {{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
    {{property3Type}}? {{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
    {{property4Type}}? {{property4Name}},{{/hasProperty4}}{{#hasProperty5}}
    {{property5Type}}? {{property5Name}},{{/hasProperty5}}{{#hasProperty6}}
    {{property6Type}}? {{property6Name}},{{/hasProperty6}}{{#hasProperty7}}
    {{property7Type}}? {{property7Name}},{{/hasProperty7}}{{#hasProperty8}}
    {{property8Type}}? {{property8Name}},{{/hasProperty8}}{{#hasProperty9}}
    {{property9Type}}? {{property9Name}},{{/hasProperty9}}{{#hasProperty10}}
    {{property10Type}}? {{property10Name}},{{/hasProperty10}}{{#hasProperty11}}
    {{property11Type}}? {{property11Name}},{{/hasProperty11}}{{#hasProperty12}}
    {{property12Type}}? {{property12Name}},{{/hasProperty12}}{{#hasProperty13}}
    {{property13Type}}? {{property13Name}},{{/hasProperty13}}{{#hasProperty14}}
    {{property14Type}}? {{property14Name}},{{/hasProperty14}}{{#hasProperty15}}
    {{property15Type}}? {{property15Name}},{{/hasProperty15}}
 {{#hasProperty1}} }{{/hasProperty1}}) {
    return {{model_name.pascalCase()}}({{#hasProperty1}}
      {{property1Name}} ?? this.{{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
      {{property2Name}} ?? this.{{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
      {{property3Name}} ?? this.{{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
      {{property4Name}} ?? this.{{property4Name}},{{/hasProperty4}}{{#hasProperty5}}
      {{property5Name}} ?? this.{{property5Name}},{{/hasProperty5}}{{#hasProperty6}}
      {{property6Name}} ?? this.{{property6Name}},{{/hasProperty6}}{{#hasProperty7}}
      {{property7Name}} ?? this.{{property7Name}},{{/hasProperty7}}{{#hasProperty8}}
      {{property8Name}} ?? this.{{property8Name}},{{/hasProperty8}}{{#hasProperty9}}
      {{property9Name}} ?? this.{{property9Name}},{{/hasProperty9}}{{#hasProperty10}}
      {{property10Name}} ?? this.{{property10Name}},{{/hasProperty10}}{{#hasProperty11}}
      {{property11Name}} ?? this.{{property11Name}},{{/hasProperty11}}{{#hasProperty12}}
      {{property12Name}} ?? this.{{property12Name}},{{/hasProperty12}}{{#hasProperty13}}
      {{property13Name}} ?? this.{{property13Name}},{{/hasProperty13}}{{#hasProperty14}}
      {{property14Name}} ?? this.{{property14Name}},{{/hasProperty14}}{{#hasProperty15}}
      {{property15Name}} ?? this.{{property15Name}},{{/hasProperty15}}
    );
  }{{/use_copywith}}
  {{#use_equatable}}
  @override
  List<Object?> get props => [{{#hasProperty1}}
        {{property1Name}},{{/hasProperty1}}{{#hasProperty2}}
        {{property2Name}},{{/hasProperty2}}{{#hasProperty3}}
        {{property3Name}},{{/hasProperty3}}{{#hasProperty4}}
        {{property4Name}},{{/hasProperty4}}{{#hasProperty5}}
        {{property5Name}},{{/hasProperty5}}{{#hasProperty6}}
        {{property6Name}},{{/hasProperty6}}{{#hasProperty7}}
        {{property7Name}},{{/hasProperty7}}{{#hasProperty8}}
        {{property8Name}},{{/hasProperty8}}{{#hasProperty9}}
        {{property9Name}},{{/hasProperty9}}{{#hasProperty10}}
        {{property10Name}},{{/hasProperty10}}{{#hasProperty11}}
        {{property11Name}},{{/hasProperty11}}{{#hasProperty12}}
        {{property12Name}},{{/hasProperty12}}{{#hasProperty13}}
        {{property13Name}},{{/hasProperty13}}{{#hasProperty14}}
        {{property14Name}},{{/hasProperty14}}{{#hasProperty15}}
        {{property15Name}},{{/hasProperty15}}
      ];
{{/use_equatable}}{{#use_json}}
  factory {{model_name.pascalCase()}}.fromJson(Map<String, dynamic> data) => _${{model_name.pascalCase()}}FromJson(data);
  Map<String, dynamic> toJson() => _${{model_name.pascalCase()}}ToJson(this);{{/use_json}}
}
