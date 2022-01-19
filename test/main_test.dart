// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//import 'package:flutter_pageview/home.dart';
import 'package:flutter_pageview/main.dart';
//import 'package:flutter_pageview/page1.dart';

void main() {
  testWidgets('Page 1', (WidgetTester tester) async {
    // Build the app and trigger the first frame.
    await tester.pumpWidget(MyApp());
    //await tester.pumpWidget(MaterialApp(home: Home()));

    var shoutBtn = find.byKey(ValueKey('shoutBtn'));
    var nameField = find.byKey(ValueKey('nameField'));

    // Verify the contents of the first page.
    expect(find.text('This is page #1.'), findsOneWidget);

    var name = 'Mark';
    await tester.enterText(nameField, name);
    await tester.pump(); // rebuilds widget after a state change
    expect(find.text('Hello, $name!'), findsOneWidget);

    await tester.tap(shoutBtn);
    await tester.pump(); // rebuilds widget after a state change
    expect(find.text('Hello, ${name.toUpperCase()}!'), findsOneWidget);
  });

  testWidgets('forward and back buttons', (WidgetTester tester) async {
    Future<void> changePage(button, expectedText) async {
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.text(expectedText), findsOneWidget);
    }

    // Build the app and trigger the first frame.
    await tester.pumpWidget(MyApp());

    var backBtn = find.byKey(ValueKey('backBtn'));
    var forwardBtn = find.byKey(ValueKey('forwardBtn'));
    //var forwardBtn = find.byIcon(Icons.arrow_forward_ios);
    // Also see the find methods byIcon, byType,
    // byWidget, and byWidgetPredicate.

    // Verify that we can change pages with the forward and back buttons.
    expect(find.text('This is page #1.'), findsOneWidget);
    await changePage(forwardBtn, 'This is page #2.');
    await changePage(forwardBtn, 'This is page #3.');
    await changePage(backBtn, 'This is page #2.');
    await changePage(backBtn, 'This is page #1.');
  });

  testWidgets('swipe left and right', (WidgetTester tester) async {
    Future<void> swipe(page, swipeLeft, expectedText) async {
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
