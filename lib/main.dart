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

// The mixin is required in order to set the TabController vsync argument.
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  final _pages = <Widget>[Page1(), Page2(), Page3()];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  IconButton _buildButton(bool forward) {
    var index = _tabController.index;
    var hide = forward ? index >= _pages.length - 1 : index == 0;
    var icon = forward ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    var method = forward ? _controller.nextPage : _controller.previousPage;
    return IconButton(
      icon: Icon(icon),
      onPressed: hide
          ? null
          : () {
              method(
                curve: Curves.easeInOut,
                duration: Duration(seconds: 1),
              );
              setPageIndex(_tabController.index + (forward ? 1 : -1));
            },
    );
  }

  void setPageIndex(int pageIndex) {
    setState(() {
      _tabController.index = pageIndex;
    });
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
                controller: _controller,
                onPageChanged: setPageIndex,
                //scrollDirection: Axis.vertical,
              ),
            ),
            TabPageSelector(
              color: Colors.pink,
              controller: _tabController,
              indicatorSize: 20,
              selectedColor: Colors.purple,
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
      color: Colors.pink[100],
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
      color: Colors.yellow[100],
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
      color: Colors.blue[100],
    );
  }
}
