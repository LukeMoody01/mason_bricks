import 'package:flutter/material.dart';{{#isBloc}}
import '../bloc/bloc.dart';{{/isBloc}}

class {{feature_name.pascalCase()}}Body extends StatelessWidget {
  const {{feature_name.pascalCase()}}Body({Key? key}) : super(key: key);
{{#isBloc}}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
      builder: (context, state) {
        return Text(state.customProperty);
      },
    );
  } {{/isBloc}} {{#isNone}}
  @override
  Widget build(BuildContext context) {
    return const Text('{{feature_name.pascalCase()}}Page');
  } {{/isNone}}
}
