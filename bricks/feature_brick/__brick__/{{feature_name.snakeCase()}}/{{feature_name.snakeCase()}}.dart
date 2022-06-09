{{#isBloc}}export 'bloc/bloc.dart';{{/isBloc}}{{#isProvider}}export 'provider/provider.dart';{{/isProvider}}{{#isRiverpod}}export 'provider/provider.dart';{{/isRiverpod}}
export 'view/{{feature_name.snakeCase()}}_page.dart';
export 'widgets/widgets.dart';
