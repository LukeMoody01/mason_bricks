part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class CustomLoginEvent extends LoginEvent {}