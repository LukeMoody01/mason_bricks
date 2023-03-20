# Model

A brick to create your model with properties and all the supporting methods, copyWith, to/from json, equatable and more!

This brick now supports configs! See below for more info.

## Table of Contents

- [How to use](#how-to-use-🚀)
  - [Model from Command Line](#command-line)
  - [Models from Json File](#using-a-json-file)
  - [Model from Config](#config)
- [Outputs](#outputs)

## How to use 🚀

### Command Line

`mason make model --model_name user --additionals "[copyWith, json, equatable]" --style basic`

Then add your properties! (Optional)

## Variables for the Command Line ✨

| Variable      | Description                                                | Default                                   | Type     |
| ------------- | ---------------------------------------------------------- | ----------------------------------------- | -------- |
| `model_name`  | The name of the model                                      | model                                     | `string` |
| `additionals` | The additionals methods/extensions you can have on a model | [copyWith, json, equatable, toString]     | `array`  |
| `style`       | The style of model                                         | basic (basic, json_serializable, freezed) | `enum`   |
| `jsonFile`    | The location of your json file                             |                                           | `string` |

### Using a Json file

WARNING: You cannot use the -o argument when using a jsonFile.

`mason make model --jsonFile .\pathToYourJsonFile`

[Example Json](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/model/json_file_template.json):

TODO: Currently there is not much error handling when it comes to the JSON files. Please raise a bug if you come across a JSON file that does not work, but should.

### Config

`mason make model -c model_config.json`

[Example Config](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/model/model_config_template.json):

```json
{
  "model_name": "super user",
  "additionals": ["copyWith", "json", "equatable", "toString"],
  "style": "json_serializable", // Could be basic, json_serializable, or freezed
  "relations": [{ "name": "user" }], // Use this when your model depends on other models
  "properties": [
    { "name": "firstName", "type": "String" },
    { "name": "lastName", "type": "String?" },
    { "name": "age", "type": "int" },
    { "name": "isHappy", "type": "bool" },
    { "name": "favouriteNumber", "type": "int" },
    { "name": "nicknames", "type": "List<String>" },
    { "name": "countriesVisited", "type": "List<String?>" },
    { "name": "friends", "type": "List<User>" } // We will need `relations` because of this model `List<User>`
  ]
}
```

## Variables for a Config ✨

| Variable      | Description                                                                    | Type     |
| ------------- | ------------------------------------------------------------------------------ | -------- |
| `model_name`  | The name of the model                                                          | `string` |
| `additionals` | The additionals methods/extensions you can have on a model                     | `array`  |
| `style`       | The style of model                                                             | `enum`   |
| `relations`   | The models that the current model will depend on and will need the imports for | `array`  |
| `properties`  | The properties for the model                                                   | `array`  |

## Outputs 📦

```
--model_name user --additionals "[copyWith, json, equatable, toString]" --style json_serializable
├── user.dart
├── user.g.dart
└── ...
```

```dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// User description
/// {@endtemplate}
@JsonSerializable()
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

  /// Creates a toString() override for User
  @override
  String toString() => 'User(name: $name, familyMembers: $familyMembers, family: $family)';
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
