# Feature Brick Tests

A supporting brick to create your features tests with 100% coverage using best practices and your state management of choice! Supports Bloc, Cubit, None.

## How to use ð

```
mason make feature_brick --feature_name login --state_management bloc
```

## Variables â¨

N/A as this is a supporting brick for feature_brick

## Outputs ð¦

```
--feature_name login --state_management bloc
âââ login
â   âââ bloc
â   â   âââ login_bloc_test.dart
â   â   âââ login_event_test.dart
â   â   âââ login_state_test.dart
â   âââ view
â   â   âââ login_page_test.dart
â   â   âââwidgets
â   â       âââ login_body_test.dart
âââ ...
```

```
--feature_name login --state_management cubit
âââ login
â   âââ cubit
â   â   âââ login_cubit_test.dart
â   â   âââ login_state_test.dart
â   âââ view
â   â   âââ login_page_test.dart
â   â   âââwidgets
â   â       âââ login_body_test.dart
âââ ...
```
