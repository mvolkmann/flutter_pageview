import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(pageController: _pageController),
    );
  }
}

class Home extends StatefulWidget {
  final PageController pageController;

  const Home({Key? key, required this.pageController}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var pages = <Widget>[
      Page1(),
      Page2(),
      Page3(),
    ];

    final actions = [
      IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: _pageIndex == 0
            ? null
            : () {
                widget.pageController.previousPage(
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                );
                setState(() => _pageIndex--);
              },
      ),
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: _pageIndex >= pages.length - 1
            ? null
            : () {
                widget.pageController.nextPage(
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                );
                setState(() => _pageIndex++);
              },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('PageView Demo'),
        actions: actions,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: pages,
                controller: widget.pageController,
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
                  for (var index = 0; index < pages.length; index++)
                    IconButton(
                      icon: Icon(
                        Icons.circle,
                        color:
                            index == _pageIndex ? Colors.black : Colors.black26,
                        size: 16,
                      ),
                      onPressed: () {
                        widget.pageController.animateToPage(
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
