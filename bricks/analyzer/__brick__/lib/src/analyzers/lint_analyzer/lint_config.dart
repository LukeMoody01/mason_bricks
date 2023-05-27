import 'package:{{analyzer_name.snakeCase()}}/src/config_builder/analysis_options_utils.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/config_builder/models/analysis_options.dart';

/// Represents raw lint config which can be merged with other raw configs.
class LintConfig {
  const LintConfig({
    required this.excludePatterns,
    required this.rules,
    required this.excludeForRulesPatterns,
    required this.antiPatterns,
    required this.shouldPrintConfig,
    required this.analysisOptionsPath,
  });

  /// Creates the config from analysis [options].
  factory LintConfig.fromAnalysisOptions(AnalysisOptions options) => LintConfig(
        excludePatterns: options.readIterableOfString(['analyzer', 'exclude']),
        rules: options.readMapOfMap(['rules'], packageRelated: true),
        excludeForRulesPatterns: options
            .readIterableOfString(['rules-exclude'], packageRelated: true),
        antiPatterns:
            options.readMapOfMap(['anti-patterns'], packageRelated: true),
        shouldPrintConfig: false,
        analysisOptionsPath: options.fullPath,
      );
  final Iterable<String> excludePatterns;
  final Map<String, Map<String, Object>> rules;
  final Iterable<String> excludeForRulesPatterns;
  final Map<String, Map<String, Object>> antiPatterns;
  final bool shouldPrintConfig;
  final String? analysisOptionsPath;

  /// Merges two configs into a single one
  ///
  /// Config coming from [overrides] has a higher priority
  /// and overrides conflicting entries.
  LintConfig merge(LintConfig overrides) => LintConfig(
        shouldPrintConfig: shouldPrintConfig || overrides.shouldPrintConfig,
        excludePatterns: {...excludePatterns, ...overrides.excludePatterns},
        rules: mergeMaps(defaults: rules, overrides: overrides.rules)
            .cast<String, Map<String, Object>>(),
        excludeForRulesPatterns: {
          ...excludeForRulesPatterns,
          ...overrides.excludeForRulesPatterns,
        },
        antiPatterns:
            mergeMaps(defaults: antiPatterns, overrides: overrides.antiPatterns)
                .cast<String, Map<String, Object>>(),
        analysisOptionsPath:
            analysisOptionsPath ?? overrides.analysisOptionsPath,
      );
}
