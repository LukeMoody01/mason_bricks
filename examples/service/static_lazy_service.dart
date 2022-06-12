import 'dart:async';

part 'istatic_lazy_service.dart';

class StaticLazyService implements IStaticLazyService { 
  const StaticLazyService._();
  static StaticLazyService? _instance;
  static StaticLazyService get instance => _instance ??= StaticLazyService._();

  @override
  FutureOr<String> myMethod() async {
    //TODO: Add Logic
    return Future.value();
  }

}
