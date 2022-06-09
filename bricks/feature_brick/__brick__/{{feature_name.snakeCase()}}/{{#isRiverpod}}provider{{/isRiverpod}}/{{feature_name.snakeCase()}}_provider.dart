import 'package:riverpod/riverpod.dart';

final {{feature_name.camelCase()}}Provider = StateNotifierProvider.autoDispose((ref) {
  return {{feature_name.pascalCase()}}();
});

class {{feature_name.pascalCase()}} extends StateNotifier<int> {
  {{feature_name.pascalCase()}}() : super(0);

  void increment() => state++;
  void decrement() => state--;
}
