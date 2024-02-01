import 'package:flutter/material.dart';

void main() {
  // runApp(MyApp());
  runApp(MyButton());
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          leading: Icon(Icons.home_filled),
          title: Text('My App Bar'),
          elevation: 10,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              print('Elevated Button Pressed');
            },
            onLongPress: () {
              print('On Long Pressed');
            },
            style: ElevatedButton.styleFrom(
                elevation: 8,
                backgroundColor: Colors.redAccent,
                minimumSize: Size(200, 50),
                maximumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)))),
            child: Text(
              'Elevated Button',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter First App',
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(24)),
              // border: Border.all(color: Colors.blueAccent, width: 5),
              // shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15,
                  spreadRadius: 0.2,
                  offset: Offset(2, 5),
                ),
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15,
                  spreadRadius: 0.2,
                  offset: Offset(5, 3),
                ),
              ],
            ),
            height: 200,
            width: 300,
            alignment: Alignment.center,
            child: Text(
              'First Container More Text and also Need More Text!',
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
                wordSpacing: 5,
                letterSpacing: 5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
