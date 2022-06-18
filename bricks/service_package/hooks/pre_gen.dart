import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final recasedPackageName = ReCase(context.vars['package_name']).snakeCase;
  final logger = context.logger;
  final methods = await _runServiceBrick(context, recasedPackageName);

  context.vars = {
    ...context.vars,
    'methods': methods,
  };

  if (!logger.confirm('? Do you want to add Models?', defaultValue: true)) {
    return;
  }
  final models = <Map<String, dynamic>>[];
  while (true) {
    final modelFileName = await _runModelBrick(context, recasedPackageName);
    models.add({'name': modelFileName});
    if (logger.confirm(
      '? Do you want to add another Model?',
      defaultValue: false,
    )) {
      continue;
    } else {
      break;
    }
  }

  context.vars = {
    ...context.vars,
    'hasModels': true,
    'models': models,
  };
}

Future<String> _runModelBrick(
    HookContext context, String recasedPackageName) async {
  final modelsDirectory =
      '${Directory.current.path..replaceAll(RegExp(r"'"), '')}\\$recasedPackageName\\lib\\src\\models';
  final directory = Directory(modelsDirectory);
  final generator = await MasonGenerator.fromBrick(
    Brick.version(name: 'model', version: '0.3.5'),
  );

  final modelName = context.logger.prompt(
    '? What is the models name?',
    defaultValue: 'model',
  );
  final useCopyWith = context.logger.confirm(
    '? Does this model have a copyWith method?',
    defaultValue: true,
  );
  final useEquatable = context.logger.confirm(
    '? Does this model use equatable?',
    defaultValue: true,
  );
  final useJson = context.logger.confirm(
    '? Does this model use json?',
    defaultValue: true,
  );

  Map<String, dynamic> preGenVars = {};
  await generator.hooks.preGen(
    vars: {
      'model_name': modelName,
      'use_copywith': useCopyWith,
      'use_equatable': useEquatable,
      'use_json': useJson,
    },
    onVarsChanged: (varsMap) {
      preGenVars = varsMap;
    },
  );

  await generator.generate(
    DirectoryGeneratorTarget(directory),
    vars: preGenVars,
    logger: context.logger,
  );

  return ReCase(modelName).snakeCase;
}

Future<List<dynamic>?> _runServiceBrick(
    HookContext context, String recasedPackageName) async {
  final serviceDirectory =
      '${Directory.current.path..replaceAll(RegExp(r"'"), '')}\\$recasedPackageName\\lib\\src';
  final directory = Directory(serviceDirectory);
  final generator = await MasonGenerator.fromBrick(
    Brick.version(name: 'service', version: '0.0.3'),
  );

  Map<String, dynamic> preGenVars = {};
  await generator.hooks.preGen(
    vars: {
      'service_name': recasedPackageName,
      'singleton_type': 'none',
    },
    onVarsChanged: (varsMap) {
      preGenVars = varsMap;
    },
  );

  await generator.generate(
    DirectoryGeneratorTarget(directory),
    vars: preGenVars,
    logger: context.logger,
  );

  return preGenVars['methods'];
}

class ReCase {
  final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');

  final symbolSet = {' ', '.', '/', '_', '\\', '-'};

  late String originalText;
  late List<String> _words;

  ReCase(String text) {
    this.originalText = text;
    this._words = _groupIntoWords(text);
  }

  List<String> _groupIntoWords(String text) {
    StringBuffer sb = StringBuffer();
    List<String> words = [];
    bool isAllCaps = text.toUpperCase() == text;

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      String? nextChar = i + 1 == text.length ? null : text[i + 1];

      if (symbolSet.contains(char)) {
        continue;
      }

      sb.write(char);

      bool isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          symbolSet.contains(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  String get snakeCase => _getSnakeCase();

  String _getSnakeCase() {
    List<String> words = this._words.map((word) => word.toLowerCase()).toList();

    return words.join('_');
  }
}
