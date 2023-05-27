/// Enum class for type of a class entity.
///
/// Used when reporting.
enum ClassType {
  generic._('class'),
  mixin._('mixin'),
  extension._('extension');


  const ClassType._(this._value);
  final String _value;

  @override
  String toString() => _value;
}
