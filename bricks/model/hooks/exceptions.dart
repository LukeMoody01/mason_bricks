/// The base model exception class
abstract class ModelException implements Exception {}

/// {@template pubspec_name_exception}
/// The exception that is raised when the brick cannot find
/// a pubspec yaml name
/// {@endtemplate}
class PubspecNameException implements ModelException {
  /// {@macro pubspec_name_exception}
  const PubspecNameException();
}
