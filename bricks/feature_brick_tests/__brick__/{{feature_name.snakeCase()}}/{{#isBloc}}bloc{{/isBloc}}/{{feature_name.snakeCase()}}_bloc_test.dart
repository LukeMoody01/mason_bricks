// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{{fullPath}}}/bloc/bloc.dart';

void main() {
  group('{{feature_name.pascalCase()}}Bloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          {{feature_name.pascalCase()}}Bloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final {{feature_name.camelCase()}}Bloc = {{feature_name.pascalCase()}}Bloc();
      expect({{feature_name.camelCase()}}Bloc.state.customProperty, equals('Default Value'));
    });

    blocTest<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
      'Custom{{feature_name.pascalCase()}}Event emits nothing',
      build: {{feature_name.pascalCase()}}Bloc.new,
      act: (bloc) => bloc.add(const Custom{{feature_name.pascalCase()}}Event()),
      expect: () => <{{feature_name.pascalCase()}}State>[],
    );
  });
}
