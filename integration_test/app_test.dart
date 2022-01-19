/*
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  testWidgets('failing test example', (WidgetTester tester) async {
    expect(2 + 2, equals(4));
  });
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_pageview/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('exercise page #1', (WidgetTester tester) async {
      Future<void> changePage(button, text) async {
        await tester.tap(button);
        await tester.pumpAndSettle();
        expect(find.text(text), findsOneWidget);
      }

      app.main();
      await tester.pumpAndSettle();

      var backBtn = find.byKey(ValueKey('backBtn'));
      var forwardBtn = find.byKey(ValueKey('forwardBtn'));

      expect(find.text('This is page #1.'), findsOneWidget);
      await changePage(forwardBtn, 'This is page #2.');
      await changePage(forwardBtn, 'This is page #3.');
      await changePage(backBtn, 'This is page #2.');
      await changePage(backBtn, 'This is page #1.');
    });
  });
}
