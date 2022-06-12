import 'package:equatable/equatable.dart';

part 'user.g.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.familyNames,
    required this.family,
  });

  final int id;
  final String name;
  final List<String> familyNames;
  final Family family;

  User copyWith({
    int? id,
    String? name,
    List<String>? familyNames,
    Family? family,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      familyNames: familyNames ?? this.familyNames,
      family: family ?? this.family,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        familyNames,
        family,
      ];

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
