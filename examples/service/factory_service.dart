import 'dart:async';

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
