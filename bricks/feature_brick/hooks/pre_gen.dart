import 'package:mason/mason.dart';

void run(HookContext context) {
  final stateManagement =
      context.vars['state_management'].toString().toLowerCase();
  final isBloc = stateManagement == 'bloc';
  final isProvider = stateManagement == 'provider';
  final isRiverpod = stateManagement == 'riverpod';
  final isNone = !isBloc && !isProvider && !isRiverpod;

  bool useEquatable = false;
  if (isBloc) {
    useEquatable = context.logger.confirm(
      '? Do you want to use equatable with Bloc? (Y/n)',
      defaultValue: true,
    );
  }

  context.vars = {
    ...context.vars,
    'isBloc': isBloc,
    'isProvider': isProvider,
    'isRiverpod': isRiverpod,
    'isNone': isNone,
    'use_equatable': useEquatable
  };
}
