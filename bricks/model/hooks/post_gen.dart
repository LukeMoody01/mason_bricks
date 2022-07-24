import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final useEquatable = context.vars["use_equatable"];
  final usesJson = context.vars["use_json"];
  final modelGenerator =
      context.vars["model_generator_mode"].toString().toLowerCase();
  final usesFreezed = modelGenerator == 'freezed';

  final directory = Directory.current.path;
  final folders = directory.toString().split('/').toList();
  final index = folders.indexWhere((folder) => folder == 'lib');
  final root = folders.sublist(0, index).join('/').toString();

  if (useEquatable) {
    final addEquatableProcess = await Process.start(
      'flutter',
      ['pub', 'add', 'equatable'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(addEquatableProcess.stdout);
    await stderr.addStream(addEquatableProcess.stderr);
  }

  if (usesJson) {
    final addJsonProcess = await Process.start(
      'flutter',
      ['pub', 'add', 'json_annotation'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(addJsonProcess.stdout);
    await stderr.addStream(addJsonProcess.stderr);
    final addJsonDevProcess = await Process.start(
      'flutter',
      ['pub', 'add', '--dev', 'json_serializable'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(addJsonDevProcess.stdout);
    await stderr.addStream(addJsonDevProcess.stderr);
  }

  if (usesFreezed) {
    final addFreezedProcess = await Process.start(
      'flutter',
      ['pub', 'add', 'freezed_annotation'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(addFreezedProcess.stdout);
    await stderr.addStream(addFreezedProcess.stderr);
    final addBuildRunnerProcess = await Process.start(
      'flutter',
      ['pub', 'add', '--dev', 'build_runner'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(addBuildRunnerProcess.stdout);
    await stderr.addStream(addBuildRunnerProcess.stderr);
    final addFreezedDevProcess = await Process.start(
      'flutter',
      ['pub', 'add', '--dev', 'freezed'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(addFreezedDevProcess.stdout);
    await stderr.addStream(addFreezedDevProcess.stderr);
  }

  if (useEquatable || usesJson || usesFreezed) {
    final pubGetProcess = await Process.start(
      'flutter',
      ['pub', 'get'],
      runInShell: true,
      workingDirectory: root,
    );
    await stdout.addStream(pubGetProcess.stdout);
    await stderr.addStream(pubGetProcess.stderr);
  }

  if (usesFreezed) {
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
