import 'package:flutter/material.dart';{{#isBloc}}
import 'package:{{{fullPath}}}/bloc/bloc.dart';{{/isBloc}}{{#isCubit}}
import 'package:{{{fullPath}}}/cubit/cubit.dart';{{/isCubit}}{{#isProvider}}
import 'package:{{{fullPath}}}/provider/provider.dart';{{/isProvider}}
import 'package:{{{fullPath}}}/widgets/{{feature_name.snakeCase()}}_body.dart';

/// {@template {{feature_name.snakeCase()}}_page}
/// A description for {{feature_name.pascalCase()}}Page
/// {@endtemplate}
class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_page}
  const {{feature_name.pascalCase()}}Page({Key? key}) : super(key: key);

  /// The static route for {{feature_name.pascalCase()}}Page
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const {{feature_name.pascalCase()}}Page());
  }
{{#isBloc}}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{feature_name.pascalCase()}}Bloc(),
      child: const Scaffold(
        body: {{feature_name.pascalCase()}}View(),
      ),
    );
  } {{/isBloc}}{{#isCubit}}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{feature_name.pascalCase()}}Cubit(),
      child: const Scaffold(
        body: {{feature_name.pascalCase()}}View(),
      ),
    );
  } {{/isCubit}} {{#isProvider}}
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>
          ChangeNotifierProvider(create: (_) => {{feature_name.pascalCase()}}Notifier()),
      child: const Scaffold(
        body: {{feature_name.pascalCase()}}View(),
      ),
    );
  } {{/isProvider}} {{#isRiverpod}}
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: {{feature_name.pascalCase()}}View(),
    );
  } {{/isRiverpod}} {{#isNone}}
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: {{feature_name.pascalCase()}}View(),
    );
  } {{/isNone}}
}

/// {@template {{feature_name.snakeCase()}}_view}
/// Displays the Body of {{feature_name.pascalCase()}}View
/// {@endtemplate}
class {{feature_name.pascalCase()}}View extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_view}
  const {{feature_name.pascalCase()}}View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const {{feature_name.pascalCase()}}Body();
  }
}
