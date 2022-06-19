# Model

A brick to create your model with properties and all the supporting methods, copyWith, to/from json, equatable and more!

This brick supports custom types and custom lists!

## How to use 🚀

```
mason make model --model_name user --use_copywith true --use_equatable true --use_json true
```

## Variables ✨

| Variable         | Description                      | Default | Type      |
| ---------------- | -------------------------------- | ------- | --------- |
| `model_name`     | The name of the model            | model   | `string`  |
| `use_copywith`   | Create copyWith method           | true    | `boolean` |
| `use_equatable`  | Creates the equatable overide    | true    | `boolean` |
| `use_json`       | Creates the from/to json methods | true    | `boolean` |
| `add_properties` | Add properties                   | true    | `boolean` |

## Outputs 📦

```
--model_name user --use_copywith true --use_equatable true --use_json true
├── user.dart
├── user.g.dart
└── ...
```

```dart
import 'package:equatable/equatable.dart';

part 'user.g.dart';

/// {@template user}
/// User description
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.name,
    required this.familyMembers,
    required this.family,
  });

  /// Creates a User from Json map
  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  /// A description for name
  final String name;

  /// A description for familyMembers
  final List<User> familyMembers;

  /// A description for family
  final Family family;

  /// Creates a copy of the current User with property changes
  User copyWith({
    String? name,
    List<User>? familyMembers,
    Family? family,
  }) {
    return User(
      name: name ?? this.name,
      familyMembers: familyMembers ?? this.familyMembers,
      family: family ?? this.family,
    );
  }

  @override
  List<Object?> get props => [
        name,
        familyMembers,
        family,
      ];

  /// Creates a Json map from a User
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

//user.g.dart
part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      familyMembers: (json['familyMembers'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      family: Family.fromJson(json['family'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'familyMembers': instance.familyMembers,
      'family': instance.family,
    };

```
