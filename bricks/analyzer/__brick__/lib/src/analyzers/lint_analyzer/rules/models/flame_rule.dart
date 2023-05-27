import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/models/rule.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/models/rule_type.dart';

/// Represents a base class for Flame-specific rules.
/// link: https://pub.dev/packages/flame
abstract class FlameRule extends Rule {
  const FlameRule({
    required super.id,
    required super.severity,
    required super.excludes,
    required super.includes,
  }) : super(
          type: RuleType.flame,
        );
}
