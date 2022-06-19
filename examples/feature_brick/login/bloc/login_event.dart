part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

/// {@template custom_login_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomLoginEvent extends LoginEvent {}
