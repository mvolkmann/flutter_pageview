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

  testWidgets('go to Page 2', (WidgetTester tester) async {
    // Build the app and trigger the first frame.
    await tester.pumpWidget(MyApp());

    //var forwardBtn = find.byIcon(Icons.arrow_forward_ios);
    var forwardBtn = find.byKey(ValueKey('forwardBtn'));
    //var backBtn = find.byKey(ValueKey('backBtn'));
    var page1 = find.byKey(ValueKey('page1'));
    // Also see the find methods byIcon, byType,
    // byWidget, and byWidgetPredicate.
    // Tap the '>' IconButton to go to next page.

    await tester.tap(forwardBtn);

    // Swipe left to advance to page #2.
    double deviceWidth = 600; // MediaQuery.of(context).size.width;
    var offset = Offset(-deviceWidth, 0);
    var speed = 300.0; // pixels per second
    await tester.fling(page1, offset, speed);

    // Wait for the page transition animation to complete.
    await tester.pump(Duration(seconds: 1));

    // Verify that the page changed.
    //expect(find.text('This is page #2.'), findsOneWidget);
  });
}
