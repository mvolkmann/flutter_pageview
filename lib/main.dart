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
  var _pageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build: _pageIndex = $_pageIndex');
    var pages = <Widget>[
      Page1(),
      Page2(),
      Page3(),
    ];

    final actions = [
      IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: /*_pageIndex == 0
            ? null
            :*/
            () {
          _pageIndex--;
          _pageController.previousPage(
            curve: Curves.easeInOut,
            duration: Duration(seconds: 1),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: /*_pageIndex >= pages.length - 1
            ? null
            :*/
            () {
          _pageIndex++;
          _pageController.nextPage(
            curve: Curves.easeInOut,
            duration: Duration(seconds: 1),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('PageView Demo'), actions: actions),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              key: GlobalKey(),
              child: PageView(
                children: pages,
                controller: _pageController,
                onPageChanged: (index) {
                  print('onPageChanged: index = $index');
                  //setState(() => _pageIndex = index);
                  _pageIndex = index;
                },
                //scrollDirection: Axis.vertical,
              ),
            ),
            SizedBox(
              key: GlobalKey(),
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
                        _pageIndex = index;
                        _pageController.animateToPage(
                          _pageIndex,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
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
