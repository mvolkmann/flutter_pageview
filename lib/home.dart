import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _controller = PageController();
  var _pageIndex = 0;
  final _pages = <Widget>[Page1(), Page2(), Page3()];

  IconButton _buildButton(bool forward) {
    var hide = forward ? _pageIndex >= _pages.length - 1 : _pageIndex == 0;
    var icon = forward ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    var method = forward ? _controller.nextPage : _controller.previousPage;
    return IconButton(
      icon: Icon(icon),
      key: Key(forward ? 'forwardBtn' : 'backBtn'),
      onPressed: hide
          ? null
          : () {
              method(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 500),
              );
              setState(() => _pageIndex += forward ? 1 : -1);
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
                controller: _controller,
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
                        _controller.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
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
