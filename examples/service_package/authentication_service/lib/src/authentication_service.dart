import 'dart:async';

part 'iauthentication_service.dart';

/// {@template authentication_service}
/// AuthenticationService description
/// {@endtemplate}
class AuthenticationService implements IAuthenticationService { 
  /// {@macro authentication_service}
  const AuthenticationService();

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
