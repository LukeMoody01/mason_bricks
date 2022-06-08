# Feature Brick

A brick to create a feature using best practices and your state management of choice! (Currently only supports bloc or none. See below for future state managements)

## How to use 🚀

```
mason make feature_brick --feature_name login --state_management bloc --use_equatable true
```

## Variables ✨

| variable           | description                     | default | type      |
| ------------------ | ------------------------------- | ------- | --------- |
| `feature_name`     | The name of the feature         | login   | `string`  |
| `state_management` | The state management of the app | bloc    | `string`  |
| `use_equatable`    | Use the equatable package       | true    | `boolean` |

## Output 📦

```
--feature_name login --state_management bloc --use_equatable true
├── login
│   ├── bloc
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
--feature_name login --state_management none --use_equatable false
├── login
│   ├── view
│   │   └── login_page.dart
│   ├── widgets
│   │   └── login_body.dart
│   └── login.dart
└── ...
```

### Todo

- [ ] Add Provider as a State Management Option
- [ ] Add RiverPod as a State Management Option
