part of 'admin.dart';

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      id: json['id'] as String,
      name: json['name'] as String,
      lastLoggedIn: json['lastLoggedIn'] as DateTime,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastLoggedIn': instance.lastLoggedIn,
    };
