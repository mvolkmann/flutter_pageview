import 'dart:convert'; // defines jsonDecode
import 'package:http/http.dart'; // defines Client

class Employees {
  // This is a free, public REST service that returns
  // an array of objects that describe employees.
  // Each contains an "employee_salary" property.
  static const url = 'http://dummy.restapiexample.com/api/v1/employees';

  static var client = Client();

  static Future<double> getAverageSalary() async {
    var response = await client.get(Uri.parse(url));

    var status = response.statusCode;
    if (status == 200) {
      try {
        var body = jsonDecode(response.body);
        var employees = body['data'];
        var total = employees.fold(0, (acc, e) {
          var salary = e['employee_salary'] as int;
          return acc + salary;
        });
        return total / employees.length;
      } catch (e) {
        rethrow;
      }
    } else {
      // When this REST service returns a 429 status, the body is HTML.
      // There's no easy way to extract a message from it,
      // but the title element contains "Too Many Requests".
      throw status == 429 ? 'too many requests' : 'bad status $status';
    }
  }
}
