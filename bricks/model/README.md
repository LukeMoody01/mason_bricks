# Model

A brick to create your model with properties and all the supporting methods, copyWith, to/from json, equatable and more!

Note: This brick currently supports 4 properties (As a test), I will be updating this to 10+ soon!

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

class User extends Equatable {
  const User(
    this.id,
    this.age,
    this.name,
    this.lastSeen,
  );

  final int id;
  final int age;
  final String name;
  final DateTime lastSeen;

  User copyWith({
    int? id,
    int? age,
    String? name,
    DateTime? lastSeen,
  }) {
    return User(
      id ?? this.id,
      age ?? this.age,
      name ?? this.name,
      lastSeen ?? this.lastSeen,
    );
  }

  @override
  List<Object?> get props => [
        id,
        age,
        name,
        lastSeen,
      ];

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Roadmap

- [ ] Support Nested Model Json
