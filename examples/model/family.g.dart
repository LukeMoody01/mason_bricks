part of 'family.dart';

Family _$FamilyFromJson(Map<String, dynamic> json) => Family(
      id: json['id'] as int,
      name: json['name'] as String,
      familyCount: json['familyCount'] as int,
    );

Map<String, dynamic> _$FamilyToJson(Family instance) => <String, dynamic>{ 
      'id': instance.id,
      'name': instance.name,
      'familyCount': instance.familyCount,
    };