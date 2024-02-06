import 'package:flutter/material.dart';

void main() {
  runApp(MyTextInput());
  // runApp(MyApp());
  // runApp(MyButton());
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: Center(
          child: Image.asset(
            'images/superman.jpg',
            fit: BoxFit.cover,
          ),
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
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black87,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.blue,
                width: 120,
                height: 120,
              ),
              Container(
                color: Colors.amber,
                width: 120,
                height: 120,
              ),
              Container(
                color: Colors.redAccent,
                width: 120,
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Container(
// color: Colors.blue,
// width: 70,
// height: 120,
// ),
// Container(
// color: Colors.amber,
// width: 70,
// height: 120,
// ),
// Container(
// color: Colors.redAccent,
// width: 70,
// height: 120,
// )
// ],
// )
}

class MyTextInput extends StatelessWidget {
  MyTextInput({super.key});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _controller,
              enabled: true,
              onTap: () {
                print('Input field tapped!');
              },
              onChanged: (String text) {
                print('$text');
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.search,
              onSubmitted: (String value) {
                _controller.clear();
                _controller.text = 'New Search';
              },
              obscureText: false,
              decoration: InputDecoration(
                // suffixIcon: Icon(Icons.add),
                // prefixIcon: Icon(Icons.abc_rounded),
                label: Text('UserName'),
                hintText: 'Please give username',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
