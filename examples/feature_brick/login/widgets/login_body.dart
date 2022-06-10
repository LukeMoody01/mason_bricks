import 'package:flutter/material.dart';
import '../bloc/bloc.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Text(state.customProperty);
      },
    );
  }
}
