import 'package:equatable/equatable.dart';

part 'model.g.dart';

class Model extends Equatable {
  const Model(
  this.id,
  this.name,
  this.age,
  this.familyNames,
  this.mapOfFamily,
  );

  final int id;
  final String name;
  final double age;
  final List<String> familyNames;
  final Map<String, dynamic> mapOfFamily;


  Model copyWith({ 
    int? id,
    String? name,
    double? age,
    List<String>? familyNames,
    Map<String, dynamic>? mapOfFamily,
  }) {
    return Model(
      id ?? this.id,
      name ?? this.name,
      age ?? this.age,
      familyNames ?? this.familyNames,
      mapOfFamily ?? this.mapOfFamily,
    );
  }
  
  @override
  List<Object?> get props => [
        id,
        name,
        age,
        familyNames,
        mapOfFamily,
      ];

  factory Model.fromJson(Map<String, dynamic> data) => _$ModelFromJson(data);
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
