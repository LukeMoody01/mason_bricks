# Feature Brick Tests

A supporting brick to create your features tests with 100% coverage using best practices and your state management of choice! Supports Bloc, Cubit, None.

## How to use 🚀

```
mason make feature_brick --feature_name login --state_management bloc
```

## Variables ✨

N/A as this is a supporting brick for feature_brick

## Outputs 📦

```
--feature_name login --state_management bloc
├── login
│   ├── bloc
│   │   ├── login_bloc_test.dart
│   │   ├── login_event_test.dart
│   │   └── login_state_test.dart
│   ├── view
│   │   ├── login_page_test.dart
│   │   └──widgets
│   │       └── login_body_test.dart
└── ...
```

```
--feature_name login --state_management cubit
├── login
│   ├── cubit
│   │   ├── login_cubit_test.dart
│   │   └── login_state_test.dart
│   ├── view
│   │   ├── login_page_test.dart
│   │   └──widgets
│   │       └── login_body_test.dart
└── ...
```
