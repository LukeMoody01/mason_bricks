import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/models/rule.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/rules/rules_list/no_empty_block/no_empty_block_rule.dart';

final _implementedRules = <String, Rule Function(Map<String, Object>)>{
  NoEmptyBlockRule.ruleId: NoEmptyBlockRule.new,
};

Iterable<String> get allRuleIds => _implementedRules.keys;

Iterable<Rule> getRulesById(Map<String, Map<String, Object>> rulesConfig) =>
    List.unmodifiable(
      _implementedRules.keys
          .where((id) => rulesConfig.keys.contains(id))
          .map<Rule>((id) => _implementedRules[id]!(rulesConfig[id]!)),
    );
