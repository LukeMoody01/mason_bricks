import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final usesFreezed = context.vars['use_freezed'] as bool;
  final logger = context.logger;
  final directory = Directory.current.path;
  List<String> folders;

  if (Platform.isWindows) {
    folders = directory.split(r'\').toList();
  } else {
    folders = directory.split('/').toList();
  }
  final libIndex = folders.indexWhere((folder) => folder == 'lib');

  if (usesFreezed &&
      logger.confirm('Would you like to generate the freezed model?',
          defaultValue: true)) {
    final root = folders.sublist(0, libIndex).join('/').toString();
    final buildRunnerProcess = await Process.start(
      'flutter',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(buildRunnerProcess.stdout);
    await stderr.addStream(buildRunnerProcess.stderr);
  }
}
