import 'dart:isolate';

import 'package:{{analyzer_name.snakeCase()}}/analyzer_plugin.dart';

void main(List<String> args, SendPort sendPort) {
  start(args, sendPort);
}
