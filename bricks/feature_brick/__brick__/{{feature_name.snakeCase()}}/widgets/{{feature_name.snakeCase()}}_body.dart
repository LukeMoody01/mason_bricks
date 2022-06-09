import 'package:flutter/material.dart';{{#isBloc}}
import '../bloc/bloc.dart';{{/isBloc}}{{#isProvider}}
import '../provider/provider.dart';{{/isProvider}}{{#isRiverpod}}
import '../provider/provider.dart';{{/isRiverpod}}

class {{feature_name.pascalCase()}}Body {{#isBloc}}extends StatelessWidget{{/isBloc}}{{#isProvider}}extends StatelessWidget{{/isProvider}}{{#isNone}}extends StatelessWidget{{/isNone}}{{#isRiverpod}}extends ConsumerWidget{{/isRiverpod}} {
  const {{feature_name.pascalCase()}}Body({Key? key}) : super(key: key);
{{#isBloc}}
  @override
  Widget build(BuildContext context{{#isRiverpod}}, WidgetRef ref{{/isRiverpod}}) {
    return BlocBuilder<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
      builder: (context, state) {
        return Text(state.customProperty);
      },
    );
  } {{/isBloc}}{{#isProvider}}
  @override
  Widget build(BuildContext context) {
    return Consumer<{{feature_name.pascalCase()}}Notifier>(
      builder: (context, state, child) {
        return Text(state.count.toString());
      },
    );
  } {{/isProvider}} {{#isRiverpod}}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch({{feature_name.camelCase()}}Provider);
    return Text(count.toString());
  } {{/isRiverpod}} {{#isNone}}
  @override
  Widget build(BuildContext context) {
    return const Text('{{feature_name.pascalCase()}}Page');
  } {{/isNone}}
}
