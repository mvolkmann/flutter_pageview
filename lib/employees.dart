import 'dart:convert'; // for jsonDecode
import 'package:http/http.dart' as http;

Future<double> getAverageSalary() async {
  // This is a free, public REST service that returns
  // an array of objects that describe employees.
  // Each contains an "employee_salary" property.
  var url = 'http://dummy.restapiexample.com/api/v1/employees';

  // http.get returns a Future, but it runs in the current thread.
  // Calling this in a new Isolate allows it to run in another thread
  // and avoid blocking the event loop of the main Isolate.
  var response = await http.get(Uri.parse(url));

  var status = response.statusCode;
  if (status == 200) {
    try {
      var employees = jsonDecode(response.body)['data'];
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
