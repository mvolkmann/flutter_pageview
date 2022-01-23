import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_pageview/main.dart';
import 'package:flutter_pageview/page1.dart';

void main() {
  testWidgets('Page1', (WidgetTester tester) async {
    // Build the app and trigger the first frame.
    // When testing a widget that does not return a `MaterialApp` widget,
    // tests generally need to begin with the following:
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Page1(),
        ),
      ),
    );

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
    Future<void> changePage(button, expectedText) async {
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.text(expectedText), findsOneWidget);
    }

    bool buttonEnabled(button) =>
        tester.widget<IconButton>(button).onPressed != null;

    // Build the app and trigger the first frame.
    // Note that MyApp creates a `MaterialApp` that creates a `Scaffold`.
    await tester.pumpWidget(MyApp());

    var backBtn = find.byKey(ValueKey('backBtn'));
    var forwardBtn = find.byKey(ValueKey('forwardBtn'));

    expect(find.text('This is page #1.'), findsOneWidget);

    // Verify that we can change pages with the forward and back buttons.
    expect(buttonEnabled(backBtn), isFalse);
    expect(buttonEnabled(forwardBtn), isTrue);
    await changePage(forwardBtn, 'This is page #2.');
    expect(buttonEnabled(backBtn), isTrue);
    await changePage(forwardBtn, 'This is page #3.');
    expect(buttonEnabled(forwardBtn), isFalse);
    await changePage(backBtn, 'This is page #2.');
    expect(buttonEnabled(forwardBtn), isTrue);
    await changePage(backBtn, 'This is page #1.');
    expect(buttonEnabled(backBtn), isFalse);
  });

  testWidgets('swipe left and right', (WidgetTester tester) async {
    Future<void> swipe(page, swipeLeft, expectedText) async {
      /*
      //TODO: How can we get the device width in a test?
      var pSize = tester.binding.window.physicalSize;
      tester.printToConsole('pSize = $pSize');
      var offset = Offset(pSize.width, pSize.height);
      tester.printToConsole(
          'local size = ${tester.binding.globalToLocal(offset)}');
      */
      double deviceWidth = 600; // MediaQuery.of(context).size.width;

      var offset = Offset(deviceWidth * (swipeLeft ? 1 : -1), 0);
      var speed = 300.0; // pixels per second
      await tester.fling(page, offset, speed);
      await tester.pumpAndSettle();

      expect(find.text(expectedText), findsOneWidget);
    }

    await tester.pumpWidget(MyApp());

    var page1 = find.byKey(ValueKey('page1'));
    var page2 = find.byKey(ValueKey('page2'));
    var page3 = find.byKey(ValueKey('page3'));

    await swipe(page1, false, 'This is page #2.'); // goes forward
    await swipe(page2, false, 'This is page #3.'); // goes forward
    await swipe(page3, false, 'This is page #3.'); // stays on same page
    await swipe(page3, true, 'This is page #2.'); // goes backward
    await swipe(page2, true, 'This is page #1.'); // goes backward
    await swipe(page1, true, 'This is page #1.'); // stays on same page
  });

  testWidgets('tap dots', (WidgetTester tester) async {
    Future<void> tapDot(int number) async {
      var dot = find.byKey(ValueKey('dot$number'));
      await tester.tap(dot);
      await tester.pumpAndSettle();
      expect(find.text('This is page #$number.'), findsOneWidget);
    }

    await tester.pumpWidget(MyApp());

    for (var number = 1; number <= 3; number++) {
      await tapDot(number);
    }
  });
}
