// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:{{{fullPath}}}/{{feature_name.snakeCase()}}.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('{{feature_name.pascalCase()}}Page', () {
    group('route', () {
      test('is routable', () {
        expect({{feature_name.pascalCase()}}Page.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders {{feature_name.pascalCase()}}View', (tester) async {
      await tester.pumpWidget(MaterialApp(home: {{feature_name.pascalCase()}}Page()));
      expect(find.byType({{feature_name.pascalCase()}}View), findsOneWidget);
    });
  });
}
