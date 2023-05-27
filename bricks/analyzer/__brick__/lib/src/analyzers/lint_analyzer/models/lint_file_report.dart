import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/issue.dart';

/// Represents the metrics report collected for a file.
class LintFileReport {
  const LintFileReport({
    required this.path,
    required this.relativePath,
    required this.issues,
  });

  const LintFileReport.onlyIssues({
    required this.path,
    required this.relativePath,
    required this.issues,
  });

  /// The path to the target file.
  final String path;

  /// The path to the target file relative to the package root.
  final String relativePath;

  /// The issues detected in the target file.
  final Iterable<Issue> issues;
}
