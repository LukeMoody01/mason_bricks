import 'package:source_span/source_span.dart';

import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/replacement.dart';
import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/severity.dart';

/// Represents an issue detected by the analysis rule.
class Issue {
  /// Initialize a newly created [Issue].
  ///
  /// The issue is associated with the given [location]. The issue will have the
  /// given [ruleId], [documentation], [severity] and [message] they will be
  /// used to classify and navigate issues in IDE or in reporters.
  /// If [verboseMessage] or [suggestion] are provided, they will be used to
  /// complete and improve the information for the end user.
  const Issue({
    required this.ruleId,
    required this.location,
    required this.severity,
    required this.message,
    this.verboseMessage,
    this.suggestion,
  });

  /// The id of the rule associated with this issue.
  final String ruleId;

  /// The source location associated with this issue.
  final SourceSpan location;

  /// The severity of this issue.
  final Severity severity;

  /// The short message (single line).
  final String message;

  /// The verbose message containing information about how the user can fix this
  /// issue or `null` if there is no information.
  final String? verboseMessage;

  /// The suggested relevant change or `null` if there is no change.
  final Replacement? suggestion;
}
