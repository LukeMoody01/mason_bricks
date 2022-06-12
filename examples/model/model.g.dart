part of 'model.dart';

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as double,
      familyNames: json['familyNames'] as List<String>,
      mapOfFamily: json['mapOfFamily'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{ 
      'id': insatnce.id,
      'name': insatnce.name,
      'age': insatnce.age,
      'familyNames': insatnce.familyNames,
      'mapOfFamily': insatnce.mapOfFamily,
    };