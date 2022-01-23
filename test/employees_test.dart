import 'package:flutter_test/flutter_test.dart'; // defines test and expect
import 'package:http/http.dart'; // defines Response
import 'package:http/testing.dart'; // defines MockClient

import 'package:flutter_pageview/employees.dart';

void main() {
  const headers = {'content-type': 'application/json'};

  test('averageSalary success', () async {
    // Create a mock client for handling HTTP requests.
    final client = MockClient((request) async {
      if (request.url.toString() != Employees.url) return Response('', 404);

      var mockJson =
          '{"data": [{"employee_salary": 100}, {"employee_salary": 200}]}';
      return Response(mockJson, 200, headers: headers);
    });

    // Tell the Employees class to use the mock client.
    Employees.client = client;

    // Test a method in the Employees class using the mock client.
    var averageSalary = await Employees.getAverageSalary();
    expect(averageSalary, 150);
  });

  test('averageSalary error', () async {
    // Create a mock client for handling HTTP requests.
    final client = MockClient((request) async {
      if (request.url.toString() != Employees.url) return Response('', 404);

      return Response('too many requests', 429, headers: headers);
    });

    // Tell the Employees class to use the mock client.
    Employees.client = client;

    // Test a method in the Employees class using the mock client.
    const expected = 'too many requests';
    try {
      await Employees.getAverageSalary();
      fail('expected Employees.getAverageSalary to throw "$expected"');
    } catch (e) {
      expect(e.toString(), expected);
    }
  });
}
