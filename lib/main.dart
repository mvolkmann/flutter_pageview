import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  var _pageIndex = 0;
  final _pages = <Widget>[Page1(), Page2(), Page3()];

  IconButton _buildButton(bool forward) {
    var hide = forward ? _pageIndex >= _pages.length - 1 : _pageIndex == 0;
    var icon = forward ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    return IconButton(
      icon: Icon(icon),
      onPressed: hide
          ? null
          : () {
              var method = forward
                  ? _pageController.nextPage
                  : _pageController.previousPage;
              method(
                curve: Curves.easeInOut,
                duration: Duration(seconds: 1),
              );
              var delta = forward ? 1 : -1;
              setState(() => _pageIndex += delta);
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView Demo'),
        leading: _buildButton(false),
        actions: [_buildButton(true)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: _pages,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _pageIndex = index);
                },
                //scrollDirection: Axis.vertical,
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var index = 0; index < _pages.length; index++)
                    IconButton(
                      icon: Icon(
                        Icons.circle,
                        color:
                            index == _pageIndex ? Colors.black : Colors.black26,
                        size: 16,
                      ),
                      onPressed: () {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                        setState(() => _pageIndex = index);
                      },
                    ),
                ],
              ),
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('This is page #1.'),
      ),
      color: Colors.pink,
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('This is page #2.'),
      ),
      color: Colors.yellow,
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('This is page #3.'),
      ),
      color: Colors.lightBlue,
    );
  }
}
