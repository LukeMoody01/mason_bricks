import 'package:{{package_name.snakeCase()}}/{{package_name.snakeCase()}}.dart';
import 'package:test/test.dart';

void main() {
  group('{{package_name.pascalCase()}}', () {
    late {{package_name.pascalCase()}} {{package_name.camelCase()}};

    setUp(() {
      {{package_name.camelCase()}} = const {{package_name.pascalCase()}}();
    });

    test('can be instantiated', () {
      expect(const {{package_name.pascalCase()}}(), isNotNull);
    });
    {{#methods}}
    group('{{name}}', () {
      test('executes happy flow', () async {
        final someValue = {{package_name.camelCase()}}.{{name}}();
        //expect(someValue, equals(someValue));
      });

      test('executes edge flow', () async {
        final someValue = {{package_name.camelCase()}}.{{name}}();
        //expect(someValue, equals(someValue));
      });
    });
    {{/methods}}
  });
}
