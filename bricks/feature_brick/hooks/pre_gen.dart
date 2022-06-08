import 'package:mason/mason.dart';

void run(HookContext context) {
  final isBloc = context.vars['state_management'] == 'bloc';
  final isNone = !isBloc;
  context.vars = {
    ...context.vars,
    'isBloc': isBloc,
    'isNone': isNone,
  };
}
