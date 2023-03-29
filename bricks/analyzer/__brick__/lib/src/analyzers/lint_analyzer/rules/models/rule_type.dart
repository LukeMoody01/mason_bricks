/// Represents a rule type. Used by documentation path construction.
enum RuleType {
  common._('common'),
  flutter._('flutter'),
  intl._('intl'),
  angular._('angular'),
  flame._('flame');


  const RuleType._(this.value);
  final String value;
}
