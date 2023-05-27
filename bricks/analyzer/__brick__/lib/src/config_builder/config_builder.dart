import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/lint_analysis_config.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/lint_config.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/rules_factory.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/config_builder/models/analysis_options.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/utils/exclude_utils.dart';

/// Builder for creating a config for all available commands.
class ConfigBuilder {
  /// Creates a raw lint config from given [options].
  static LintConfig getLintConfigFromOptions(AnalysisOptions options) =>
      LintConfig.fromAnalysisOptions(options);

  /// Creates a lint config from given raw config.
  static LintAnalysisConfig getLintAnalysisConfig(
    LintConfig config,
    String rootFolder,
  ) {
    return LintAnalysisConfig(
      createAbsolutePatterns(config.excludePatterns, rootFolder),
      getRulesById(config.rules),
      createAbsolutePatterns(config.excludeForRulesPatterns, rootFolder),
      rootFolder,
      config.analysisOptionsPath,
    );
  }
}
