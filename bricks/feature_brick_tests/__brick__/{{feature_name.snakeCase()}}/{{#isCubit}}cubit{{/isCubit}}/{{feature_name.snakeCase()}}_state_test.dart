// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:{{{fullPath}}}/cubit/cubit.dart';

void main() {
  group('{{feature_name.pascalCase()}}State', () {
    test('supports value equality', () {
      expect(
        {{feature_name.pascalCase()}}State(),
        equals(
          const {{feature_name.pascalCase()}}State(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const {{feature_name.pascalCase()}}State(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const {{feature_name.camelCase()}}State = {{feature_name.pascalCase()}}State(
            customProperty: 'My property',
          );
          expect(
            {{feature_name.camelCase()}}State.copyWith(),
            equals({{feature_name.camelCase()}}State),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const {{feature_name.camelCase()}}State = {{feature_name.pascalCase()}}State(
            customProperty: 'My property',
          );
          final other{{feature_name.pascalCase()}}State = {{feature_name.pascalCase()}}State(
            customProperty: 'My property 2',
          );
          expect({{feature_name.camelCase()}}State, isNot(equals(other{{feature_name.pascalCase()}}State)));

          expect(
            {{feature_name.camelCase()}}State.copyWith(
              customProperty: other{{feature_name.pascalCase()}}State.customProperty,
            ),
            equals(other{{feature_name.pascalCase()}}State),
          );
        },
      );
    });
  });
}
