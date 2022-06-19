import 'package:mason/mason.dart';

void run(HookContext context) {
  final stateManagement =
      context.vars['state_management'].toString().toLowerCase();
  final isBloc = stateManagement == 'bloc';
  final isCubit = stateManagement == 'cubit';
  final isProvider = stateManagement == 'provider';
  final isRiverpod = stateManagement == 'riverpod';
  final isNone = !isBloc && !isCubit && !isProvider && !isRiverpod;

  bool useEquatable = false;
  if (isBloc || isCubit) {
    useEquatable = context.logger.confirm(
      '? Do you want to use equatable with your $stateManagement? (Y/n)',
      defaultValue: true,
    );
  }

  context.vars = {
    ...context.vars,
    'isBloc': isBloc,
    'isCubit': isCubit,
    'isProvider': isProvider,
    'isRiverpod': isRiverpod,
    'isNone': isNone,
    'use_equatable': useEquatable
  };
}
