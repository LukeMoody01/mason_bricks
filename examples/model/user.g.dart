part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      familyNames: json['familyNames'] as List<String>,
      family: Family.fromJson(json['family'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{ 
      'id': instance.id,
      'name': instance.name,
      'familyNames': instance.familyNames,
      'family': instance.family,
    };