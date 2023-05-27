// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/lint_utils.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/internal_resolved_unit_result.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/issue.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/models/common_rule.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/rule_utils.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/utils/node_utils.dart';

part 'visitor.dart';

// Inspired by TSLint (https://palantir.github.io/tslint/rules/no-empty/)

class NoEmptyBlockRule extends CommonRule {
  NoEmptyBlockRule([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
          severity: readSeverity(config, Severity.style),
          excludes: readExcludes(config),
          includes: readIncludes(config),
        );
  static const String ruleId = 'no-empty-block';

  static const _warning =
      'Block is empty. Empty blocks are often indicators of missing code. wahh';

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    final visitor = _Visitor();

    source.unit.visitChildren(visitor);

    return visitor.emptyBlocks
        .map(
          (block) => createIssue(
            rule: this,
            location: NodeUtils.nodeLocation(node: block, source: source),
            message: _warning,
          ),
        )
        .toList(growable: false);
  }
}
