import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyCupertinoApp());
}

class MyCupertinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MyIosApp(),
    );
  }
}

class MyIosApp extends StatelessWidget {
  const MyIosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Icon(
          CupertinoIcons.home,
          size: 24,
        ),
        middle: Text('Home'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(child: Text('Click Me'), onPressed: () {}),
            CupertinoButton.filled(child: Text('Click Me'), onPressed: () {}),
            ElevatedButton(child: Text('Click Me'), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
