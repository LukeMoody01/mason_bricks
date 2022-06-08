part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.customProperty = 'Default Value',
  });

  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  LoginState copyWith({
    String? customProperty,
  }) {
    return LoginState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial() : super();
}
