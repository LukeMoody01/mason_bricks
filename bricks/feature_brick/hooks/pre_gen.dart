import 'package:mason/mason.dart';

void run(HookContext context) {
  final isBloc =
      context.vars['state_management'].toString().toLowerCase() == 'bloc';
  final isProvider =
      context.vars['state_management'].toString().toLowerCase() == 'provider';
  final isNone = !isBloc && !isProvider;

  String useEquatable = 'n';
  if (isBloc) {
    useEquatable = context.logger.prompt(
      '? Do you want to use equatable with Bloc? (Y/n)',
      defaultValue: 'Y',
    );
  }

  context.vars = {
    ...context.vars,
    'isBloc': isBloc,
    'isProvider': isProvider,
    'isNone': isNone,
    'use_equatable': useEquatable.toLowerCase() == 'y' ? true : false
  };
}
