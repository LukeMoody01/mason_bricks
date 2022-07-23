// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:{{{fullPath}}}/bloc/bloc.dart';

void main() {
  group('{{feature_name.pascalCase()}}Event', () { {{#use_equatable}} 
    group('Custom{{feature_name.pascalCase()}}Event', () {
      test('supports value equality', () {
        expect(
          const Custom{{feature_name.pascalCase()}}Event(),
          isNotNull
        );
      });
    });{{/use_equatable}}
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          Custom{{feature_name.pascalCase()}}Event(),
          equals(const Custom{{feature_name.pascalCase()}}Event()),
        );
      });
    });
  });
}
