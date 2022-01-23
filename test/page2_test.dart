import 'package:flutter/material.dart'; // defines MaterialApp and Scaffold
import 'package:flutter_test/flutter_test.dart'; // defines testWidgets and expect
import 'package:http/http.dart'; // defines Response
import 'package:http/testing.dart'; // defines MockClient

import 'package:flutter_pageview/employees.dart';

import 'package:flutter_pageview/page2.dart';

void main() {
  testWidgets('Page2', (WidgetTester tester) async {
    // See https://github.com/flutter/flutter/pull/49844 which says:
    // "Outside of browser contexts, we (Flutter) override the
    // `HttpClient implementation to one that always returns 400.
    // This helps make tests more hermetic and
    // prevent users from making mistakes in tests by
    // introducing real life network calls into a unit test."

    // Create a mock client for handling HTTP requests.
    final client = MockClient((request) async {
      if (request.url.toString() != Employees.url) return Response('', 404);

      var mockJson =
          '{"data": [{"employee_salary": 100}, {"employee_salary": 200}]}';
      const headers = {'content-type': 'application/json'};
      return Response(mockJson, 200, headers: headers);
    });

    // Tell the Employees class to use the mock client.
    Employees.client = client;

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Page2())));

    //var refreshBtn = find.byKey(ValueKey('page2Refresh'));

    expect(find.text('This is page #2.'), findsOneWidget);

    //TODO: How can you wait for the REST call to complete before running this?
    //expect(find.text('Average Salary: \$150'), findsOneWidget);
  });
}
