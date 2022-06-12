import 'dart:async';

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
