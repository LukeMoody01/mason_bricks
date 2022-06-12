import 'package:equatable/equatable.dart';

part 'family.g.dart';

class Family extends Equatable {
  const Family({ 
  required this.id,
  required this.name,
  required this.familyCount,
  });

  final int id;
  final String name;
  final int familyCount;


  Family copyWith({ 
    int? id,
    String? name,
    int? familyCount,
  }) {
    return Family(
      id: id ?? this.id,
      name: name ?? this.name,
      familyCount: familyCount ?? this.familyCount,
    );
  }
  
  @override
  List<Object?> get props => [
        id,
        name,
        familyCount,
      ];

  factory Family.fromJson(Map<String, dynamic> data) => _$FamilyFromJson(data);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}
