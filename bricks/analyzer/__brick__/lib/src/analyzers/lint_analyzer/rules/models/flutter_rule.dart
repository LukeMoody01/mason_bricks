import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/models/rule.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/models/rule_type.dart';

/// Represents a base class for Flutter-specific rules.
abstract class FlutterRule extends Rule {
  const FlutterRule({
    required super.id,
    required super.severity,
    required super.excludes,
    required super.includes,
  }) : super(
          type: RuleType.flutter,
        );
}
