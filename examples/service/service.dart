import 'dart:async';

part 'iservice.dart';

class Service implements IService {
  const Service();

  @override
  FutureOr<String> myMethod() async {
    //TODO: Add Logic
    return Future.value();
  }
}
