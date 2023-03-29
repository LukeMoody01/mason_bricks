# Analyzer
Introducing Analyzer brick, a powerful foundation for building your personalized Flutter/Dart analyzer package! At present, there is a lack of comprehensive guides or streamlined methods for creating custom analyzers. Analyzer aims to fill that gap by providing a user-friendly base for crafting the perfect analyzer tailored to your team's projects.

Drawing inspiration from the well-known dart-code-analyzer, Analyzer currently offers a lint analyzer, without compromising on functionality. Get started with Analyzer today and elevate your code analysis experience!

## How to use 🚀

### Command Line

`mason make analyzer --analyzer_name moody_analyzer`

## Variables for the Command Line ✨

| Variable        | Description                      | Default         | Type     |
| --------------- | -------------------------------- | --------------- | -------- |
| `analyzer_name` | The name of your custom analyzer | custom_analyzer | `string` |

## Run the plugin in IDE

In your project, you can add your analyzer to the `pubspec.yaml` like so:
```yaml
  custom_analyzer:
    path: path\to\your\analyzer
```

You can then add your rules inside of the `analysis_options.yaml` like so:
```yaml

analyzer:
  plugins:
    - custom_analyzer

custom_analyzer:
  rules:
    - no-empty-block
```

## Creating new lint rule

To create a new rule:

1. Choose a rule name according to our naming guide or take it from existing issue for the rule.
2. Create a rule `.dart` file under `lib/src/analyzers/lint_analyzer/rules/rules_list`.
3. Create a class that extends an abstract rule class depending on your rule type. Available classes: `FlutterRule`, `CommonRule`. Add a public field with rule id, documentation url.

    The class constructor should take `Map<String, Object> config` parameter which represents config that is passed to the rule from the `analysis_options.yaml`. Example:

    ```dart
    BinaryExpressionOperandOrderRule([
        Map<String, Object> config = const {},
    ]) : super(
            id: ruleId,
            documentation: Uri.parse(_documentationUrl),
            severity: readSeverity(config, Severity.style),
        );
    ```

4. Add a visitor class which extends any of the base visitors. Usually you will need `RecursiveAstVisitor`. All visitors are [listed there](https://github.com/dart-lang/sdk/blob/master/pkg/analyzer/lib/dart/ast/visitor.dart). Visitor should be added to a separate file and imported with `part` directive.
5. Add methods overrides to the visitor class for nodes that you want to check (ex. `visitBinaryExpression`, `visitBlock`).
6. Collect all data needed for the rule (we usually use a private field for data storage and public getter to access it from the `check` method).
7. In the rule class add override to `check` method. Create a visitor instance and visit all compilation unit children with it.

    Convert data to `Issue`'s and return them from the method. Example:

    ```dart
        @override
        Iterable<Issue> check(Source source) {
        final visitor = _Visitor();

        source.compilationUnit.visitChildren(visitor);

        return visitor.binaryExpressions
            .map((lit) => createIssue(
                this,
                nodeLocation(lit, source),
                _warningMessage,
                Replacement(
                    comment: _correctionComment,
                    replacement: '${lit.rightOperand} ${lit.operator} ${lit.leftOperand}',
                ),
            ))
            .toList(growable: false);
        }
    ```

    > Override `toJson` method if the rule is configurable.
8. Add the rule to the `lib/src/analyzers/lint_analyzer/rules/rules_factory.dart`. Example:

    ```dart
    final _implementedRules = <String, Rule Function(Map<String, Object>)>{
        ...
        BinaryExpressionOperandOrderRule.ruleId: (config) =>
      BinaryExpressionOperandOrderRule(config: config),
      ...
    }
    ```