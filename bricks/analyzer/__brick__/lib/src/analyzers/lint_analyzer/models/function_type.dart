/// Enum class for type of a function entity.
///
/// Used when reporting.
enum FunctionType {
  constructor._('constructor'),
  method._('method'),
  function._('function'),
  getter._('getter'),
  setter._('setter');


  const FunctionType._(this._value);
  final String _value;

  @override
  String toString() => _value;
}
