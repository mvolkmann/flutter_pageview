import 'package:flutter/material.dart';
import './employees.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  var average = 0.0;
  var message = '';

  void loadData() async {
    try {
      average = await Employees.getAverageSalary();
      message = '';
    } catch (e) {
      print('error: $e');
      message = e.toString();
    } finally {
      setState(() {});
    }
  }

  // initState cannot be async.
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('This is page #2.'),
            if (message.isEmpty && average == 0.0) CircularProgressIndicator(),
            if (average != 0) Text('Average Salary: \$${average.round()}'),
            if (message.isNotEmpty) Text('Message: $message'),
            ElevatedButton(
              child: Text('Refresh'),
              key: Key('page2Refresh'),
              onPressed: () {
                setState(() {
                  message = '';
                  average = 0.0;
                  loadData();
                });
              },
            ),
          ],
        ),
      ),
      color: Colors.yellow[100],
      key: Key('page2'),
    );
  }
}
