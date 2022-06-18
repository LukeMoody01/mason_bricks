# Service Package

A brick to create your service package including your methods, models, tests, and more!

This brick makes use of the MasonGenerator and wraps 2 other bricks (service and model) to create a fully fledged package with tests already pre generated!

## How to use 🚀

```
mason make service_package --package_name "authentication repository" --package_description "Authentication Package"
```

## Variables ✨

| Variable              | Description             | Default                       | Type     |
| --------------------- | ----------------------- | ----------------------------- | -------- |
| `package_name`        | The name of the package | data repository               | `string` |
| `package_description` | The package description | A default package description | `string` |

## Bricks Used 🧱

| Brick                                                | Version |
| ---------------------------------------------------- | ------- |
| [service](https://brickhub.dev/bricks/service/0.0.3) | 0.0.3   |
| [model](https://brickhub.dev/bricks/model/0.3.5)     | 0.3.5   |

## Outputs 📦

```
--package_name "authentication repository" --package_description "Authentication Package"
├── authentication_repository
│   ├── lib
│   │   ├── src
│   │   │   ├── models
│   │   │   │   ├── yourModelOne.dart
│   │   │   │   ├── yourModelTwo.dart
│   │   │   │   └── etc
│   │   │   ├── authentication_repository.dart
│   │   │   └── iauthentication_repository.dart
│   │   └── authentication_repository.dart
│   ├── test
│   │   └── src
│   │       └── authentication_repository_test.dart
│   ├── .gitignore
│   ├── analysis_options.yaml
│   ├── pubspec.yaml
│   └── README.md
└── ...
```

### Service File

```dart
part 'iauthentication_repository.dart';

/// {@template authentication_repository}
/// AuthenticationRepository description
/// {@endtemplate}
class AuthenticationRepository implements IAuthenticationRepository {
  /// {@macro authentication_repository}
  const AuthenticationRepository();

  @override
  FutureOr<String> authenticateUser() async {
    //TODO: Add Logic
    return Future.value();
  }

  @override
  FutureOr<String> logOut() async {
    //TODO: Add Logic
    return Future.value();
  }
}
```

### Tests File

```dart
import 'package:data_repository/data_repository.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationRepository', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = const AuthenticationRepository();
    });

    test('can be instantiated', () {
      expect(const AuthenticationRepository(), isNotNull);
    });

    group('authenticateUser', () {
      test('executes happy flow', () async {
        final someValue = authenticationRepository.authenticateUser();
        //expect(someValue, equals(someValue));
      });

      test('executes edge flow', () async {
        final someValue = authenticationRepository.authenticateUser();
        //expect(someValue, equals(someValue));
      });
    });

    group('logOut', () {
      test('executes happy flow', () async {
        final someValue = authenticationRepository.logOut();
        //expect(someValue, equals(someValue));
      });

      test('executes edge flow', () async {
        final someValue = authenticationRepository.logOut();
        //expect(someValue, equals(someValue));
      });
    });
  });
}
```

### Roadmap

- [ ] Add equatable as package if a model uses it
- [ ] Wait for other bricks to be updated
