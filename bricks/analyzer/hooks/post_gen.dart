import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final directory = Directory.current.path;

  final progress = context.logger.progress(
    'Getting dependencies',
    options: ProgressOptions(
      animation: ProgressAnimation(
          frames: ['🌑', '🌒', '🌓', '🌔', '🌕', '🌖', '🌗', '🌘']),
    ),
  );
  await Process.run(
    'dart',
    ['pub', 'get'],
    runInShell: true,
    workingDirectory: directory,
  );
  await Process.run(
    'dart',
    ['pub', 'get'],
    runInShell: true,
    workingDirectory: directory + r'\tools\analyzer_plugin',
  );
  progress.complete();
}
