import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:source_span/source_span.dart';

import 'package:{{analyzer_name.snakeCase()}}/src/analyzers/lint_analyzer/models/internal_resolved_unit_result.dart';

abstract class NodeUtils {
  static const _flutterInternalEntryFunctions = {
    'registerPlugins',
    'testExecutable'
  };

  /// Returns [SourceSpan] with information about original code for [node] from [source].
  static SourceSpan nodeLocation({
    required SyntacticEntity node,
    required InternalResolvedUnitResult source,
    SyntacticEntity? endNode,
    bool withCommentOrMetadata = false,
  }) {
    final offset = !withCommentOrMetadata && node is AnnotatedNode
        ? node.firstTokenAfterCommentAndMetadata.offset
        : node.offset;
    final end = endNode?.end ?? node.end;
    final sourceUrl = Uri.file(source.path);

    final offsetLocation = source.lineInfo.getLocation(offset);
    final endLocation = source.lineInfo.getLocation(end);

    return SourceSpan(
      SourceLocation(
        offset,
        sourceUrl: sourceUrl,
        line: offsetLocation.lineNumber,
        column: offsetLocation.columnNumber,
      ),
      SourceLocation(
        end,
        sourceUrl: sourceUrl,
        line: endLocation.lineNumber,
        column: endLocation.columnNumber,
      ),
      source.content.substring(offset, end),
    );
  }

  static bool isOverride(List<Annotation> metadata) => metadata.any(
        (node) =>
            node.name.name == 'override' && node.atSign.type == TokenType.AT,
      );

  static bool haveSameParameterType(Expression left, Expression right) =>
      left.staticParameterElement?.type == right.staticParameterElement?.type;

  static bool isEntrypoint(String name, NodeList<Annotation> metadata) =>
      name == 'main' ||
      _hasPragmaAnnotation(metadata) ||
      _flutterInternalEntryFunctions.contains(name);

  /// See https://github.com/dart-lang/sdk/blob/master/runtime/docs/compiler/aot/entry_point_pragma.md.
  static bool _hasPragmaAnnotation(Iterable<Annotation> metadata) =>
      metadata.where((annotation) {
        final arguments = annotation.arguments;

        return annotation.name.name == 'pragma' &&
            arguments != null &&
            arguments.arguments
                .where(
                  (argument) =>
                      argument is SimpleStringLiteral &&
                      argument.stringValue == 'vm:entry-point',
                )
                .isNotEmpty;
      }).isNotEmpty;
}
