import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart'; // defines Client and Response
import 'package:mockito/mockito.dart'; // not using here

import 'package:flutter_pageview/employees.dart';

void main() {
  test('average salary success', () async {
    /* THIS IS NOT WORKING YET.
    var json = '{"data": [{"employee_salary": 100}, {"employee_salary": 200}]}';

    when(
      client.get(Employees.url),
    ).thenAnswer(
      (_) async => Response(json, 200),
    );

    var averageSalary = await Employees.getAverageSalary();
    expect(averageSalary, 150);
    */
  });
}
