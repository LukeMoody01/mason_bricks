# Feature Brick

A brick to create a feature using best practices and your state management of choice! (Currently only supports bloc or none. See below for future state managements)

## How to use 🚀

```
mason make feature_brick --feature_name login --state_management bloc --use_equatable true
```

## Variables ✨

| variable           | description                     | default | type      | conditional | when       |
| ------------------ | ------------------------------- | ------- | --------- | ----------- | ---------- |
| `feature_name`     | The name of the feature         | login   | `string`  | false       | N/A        |
| `state_management` | The state management of the app | bloc    | `string`  | false       | N/A        |
| `use_equatable`    | Use the equatable package       | true    | `boolean` | true        | Using Bloc |

## Output 📦

```
--feature_name login --state_management bloc
├── login
│   ├── bloc
│   │   ├── bloc.dart
│   │   ├── login_bloc.dart
│   │   ├── login_event.dart
│   │   └── login_state.dart
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   └── login_body.dart
│   └── login.dart
└── ...
```

```
--feature_name login --state_management provider
├── login
│   ├── provider
│   │   ├── login_provider.dart
│   │   ├── provider.dart
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   └── login_body.dart
│   └── login.dart
└── ...
```

```
--feature_name login --state_management none
├── login
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   └── login_body.dart
│   └── login.dart
└── ...
```

### Roadmap

- [ ] Add RiverPod as a State Management Option
- [ ] Add Domain Layer Option
- [ ] Add Models into Domain Layer Option
- [ ] Add Services Option
