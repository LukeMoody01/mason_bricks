import 'package:flutter/material.dart';{{#isBloc}}
import 'package:{{{fullPath}}}/bloc/bloc.dart';{{/isBloc}}{{#isCubit}}
import 'package:{{{fullPath}}}/cubit/cubit.dart';{{/isCubit}}{{#isProvider}}
import 'package:{{{fullPath}}}/provider/provider.dart';{{/isProvider}}{{#isRiverpod}}
import 'package:{{{fullPath}}}/provider/provider.dart';{{/isRiverpod}}

/// {@template {{feature_name.snakeCase()}}_body}
/// Body of the {{feature_name.pascalCase()}}Page.
///
/// Add what it does
/// {@endtemplate}
class {{feature_name.pascalCase()}}Body {{#isBloc}}extends StatelessWidget{{/isBloc}}{{#isCubit}}extends StatelessWidget{{/isCubit}}{{#isProvider}}extends StatelessWidget{{/isProvider}}{{#isNone}}extends StatelessWidget{{/isNone}}{{#isRiverpod}}extends ConsumerWidget{{/isRiverpod}} {
  /// {@macro {{feature_name.snakeCase()}}_body}
  const {{feature_name.pascalCase()}}Body({super.key});
{{#isBloc}}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }{{/isBloc}}{{#isCubit}}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{feature_name.pascalCase()}}Cubit, {{feature_name.pascalCase()}}State>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }{{/isCubit}}{{#isProvider}}
  @override
  Widget build(BuildContext context) {
    return Consumer<{{feature_name.pascalCase()}}Notifier>(
      builder: (context, state, child) {
        return Center(child: Text(state.count.toString()));
      },
    );
  }{{/isProvider}}{{#isRiverpod}}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch({{feature_name.camelCase()}}Provider);
    return Text(count.toString());
  }{{/isRiverpod}}{{#isNone}}
  @override
  Widget build(BuildContext context) {
    return const Center(child:Text('{{feature_name.pascalCase()}}Page'));
  }{{/isNone}}
}
