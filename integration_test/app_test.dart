import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_pageview/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Page1', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find widgets.
    var shoutBtn = find.byKey(ValueKey('shoutBtn'));
    var nameField = find.byKey(ValueKey('nameField'));

    // Verify the contents of the first page.
    expect(find.text('This is page #1.'), findsOneWidget);

    var name = 'Mark';
    await tester.enterText(nameField, name);
    await tester.pumpAndSettle();
    expect(find.text('Hello, $name!'), findsOneWidget);

    await tester.tap(shoutBtn);
    await tester.pumpAndSettle();
    expect(find.text('Hello, ${name.toUpperCase()}!'), findsOneWidget);
  });

  testWidgets('forward and back buttons', (WidgetTester tester) async {
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

  testWidgets(
    'swipe left and right',
    (WidgetTester tester) async {
      Future<void> swipe(page, swipeLeft, expectedText) async {
        //TODO: How can we get the device width in a test?
        double deviceWidth = 600; // MediaQuery.of(context).size.width;

        var offset = Offset(deviceWidth * (swipeLeft ? 1 : -1), 0);
        var speed = 300.0; // pixels per second
        await tester.fling(page, offset, speed);
        await tester.pumpAndSettle();

        //TODO: Why does this fail in this integration test,
        //TODO: but it passes in a widget test with the SAME CODE?
        expect(find.text(expectedText), findsOneWidget);
      }

      app.main();
      await tester.pumpAndSettle();

      var page1 = find.byKey(ValueKey('page1'));
      var page2 = find.byKey(ValueKey('page2'));
      var page3 = find.byKey(ValueKey('page3'));

      await swipe(page1, false, 'This is page #2.'); // goes forward
      await swipe(page2, false, 'This is page #3.'); // goes forward
      await swipe(page3, false, 'This is page #3.'); // stays on same page
      await swipe(page3, true, 'This is page #2.'); // goes backward
      await swipe(page2, true, 'This is page #1.'); // goes backward
      await swipe(page1, true, 'This is page #1.'); // stays on same page
    },
    skip: true,
  );

  testWidgets('tap dots', (WidgetTester tester) async {
    Future<void> tapDot(int number) async {
      var dot = find.byKey(ValueKey('dot$number'));
      await tester.tap(dot);
      await tester.pumpAndSettle();
      expect(find.text('This is page #$number.'), findsOneWidget);
    }

    app.main();
    await tester.pumpAndSettle();

    for (var number = 1; number <= 3; number++) {
      await tapDot(number);
    }
  });
}
