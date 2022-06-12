# Service

A brick to create your service and interface with your defined methods. With optional singleton handling!

## How to use 🚀

```
mason make service --service_name service --singleton_type static-instance-singleton
```

## Variables ✨

| Variable         | Description                | Default                   | Type     |
| ---------------- | -------------------------- | ------------------------- | -------- |
| `service_name`   | The name of the service    | service                   | `string` |
| `singleton_type` | The services instance type | static-instance-singleton | `enum`   |

## Outputs 📦

```
--service_name "login service" --singleton_type static-instance-singleton
├── login_service.dart
├── ilogin_service.dart
└── ...
```

```dart
//--service_name "static service" --singleton_type static-instance-singleton
part 'istatic_service.dart';

class StaticService implements IStaticService {
  const StaticService._();
  static final StaticService instance = StaticService._();

  @override
  FutureOr<String> myMethod() async {
    //TODO: Add Logic
    return Future.value();
  }
}

//istatic_service.dart
part of 'static_service.dart';

/// A description for static service
abstract class IStaticService{
  /// A description for myMethod
  FutureOr<String> myMethod();
}
```

```dart
//--service_name "factory service" --singleton_type factory-singleton
part 'ifactory_service.dart';

class FactoryService implements IFactoryService {
  const FactoryService._();
  static final FactoryService _instance = FactoryService._();

  factory FactoryService() {
    return _instance;
  }

  @override
  FutureOr<String> myMethod() async {
    //TODO: Add Logic
    return Future.value();
  }
}

//ifactory_service.dart
part of 'factory_service.dart';

/// A description for factory service
abstract class IFactoryService{
  /// A description for myMethod
  FutureOr<String> myMethod();
}
```

```dart
//--service_name service --singleton_type none
part 'iservice.dart';

class Service implements IService {
  const Service();

  @override
  FutureOr<String> myMethod() async {
    //TODO: Add Logic
    return Future.value();
  }
}

//iservice.dart
part of 'service.dart';

/// A description for service
abstract class IService {
  /// A description for myMethod
  FutureOr<String> myMethod();
}
```

### Roadmap

- [ ] Support for getIt
