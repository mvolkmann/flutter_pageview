import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var name = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Text('This is page #1.'),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              labelText: 'Name',
            ),
            initialValue: name,
            key: Key('nameField'),
            onChanged: (String value) {
              setState(() => name = value);
            },
          ),
          Text(name.isEmpty ? '' : 'Hello, $name!'),
          ElevatedButton(
            child: Text('SHOUT'),
            key: Key('shoutBtn'),
            onPressed: () {
              setState(() => name = name.toUpperCase());
            },
          ),
        ]),
      ),
      color: Colors.pink[100],
      key: Key('page1'),
    );
  }
}
