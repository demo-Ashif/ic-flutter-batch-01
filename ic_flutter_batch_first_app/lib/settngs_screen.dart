import 'package:flutter/material.dart';
import 'package:ic_flutter_batch_first_app/home_screen.dart';

class SettingsScreen extends StatelessWidget {
  final String message;

  const SettingsScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Data from Profile: $message',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    //predicate
                    (route) => false);
              },
              child: Text('Back to Home'),
            )
          ],
        ),
      ),
    );
  }
}
