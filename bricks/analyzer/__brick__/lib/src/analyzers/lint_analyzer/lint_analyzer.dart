import 'package:analyzer/dart/analysis/results.dart';
import 'package:path/path.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/lint_analysis_config.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/internal_resolved_unit_result.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/issue.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/lint_file_report.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/utils/exclude_utils.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/utils/suppression.dart';

/// The analyzer responsible for collecting lint reports.
class LintAnalyzer {
  const LintAnalyzer();

  /// Returns a lint report for analyzing given [result].
  /// The analysis is configured with the [config].
  LintFileReport? runPluginAnalysis(
    ResolvedUnitResult result,
    LintAnalysisConfig config,
    String rootFolder,
  ) {
    if (!isExcluded(result.path, config.globalExcludes)) {
      return _analyzeFile(
        result,
        config,
        rootFolder,
        filePath: result.path,
      );
    }

    return null;
  }

  LintFileReport? _analyzeFile(
    ResolvedUnitResult result,
    LintAnalysisConfig config,
    String rootFolder, {
    String? filePath,
  }) {
    if (filePath == null || !_isSupported(result)) {
      return null;
    }

    final ignores = Suppression(
      result.content,
      result.lineInfo,
      supportsTypeLintIgnore: true,
    );
    final internalResult = InternalResolvedUnitResult(
      filePath,
      result.content,
      result.unit,
      result.lineInfo,
    );
    final relativePath = relative(filePath, from: rootFolder);

    final issues = <Issue>[];
    if (!isExcluded(filePath, config.rulesExcludes)) {
      issues.addAll(_checkOnCodeIssues(ignores, internalResult, config));
    }

    return LintFileReport.onlyIssues(
      path: filePath,
      relativePath: relativePath,
      issues: issues,
    );
  }

  Iterable<Issue> _checkOnCodeIssues(
    Suppression ignores,
    InternalResolvedUnitResult source,
    LintAnalysisConfig config,
  ) =>
      config.codeRules
          .where(
            (rule) =>
                !ignores.isSuppressed(rule.id) &&
                isIncluded(
                  source.path,
                  createAbsolutePatterns(rule.includes, config.rootFolder),
                ) &&
                !isExcluded(
                  source.path,
                  createAbsolutePatterns(rule.excludes, config.rootFolder),
                ),
          )
          .expand(
            (rule) => rule.check(source).where(
                  (issue) => !ignores.isSuppressedAt(
                    issue.ruleId,
                    issue.location.start.line,
                  ),
                ),
          )
          .toList();

  bool _isSupported(FileResult result) =>
      result.path.endsWith('.dart') &&
      !result.path.endsWith('.g.dart') &&
      !result.path.endsWith('.freezed.dart');
}
