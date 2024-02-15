import 'package:flutter/material.dart';
import 'package:ic_flutter_batch_first_app/settngs_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String profileName;

  const ProfileScreen({
    super.key,
    required this.profileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Data: $profileName',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SettingsScreen(),
                //   ),
                // );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      message: 'Name is $profileName',
                    ),
                  ),
                );
              },
              child: Text('Go To Settings'),
            )
          ],
        ),
      ),
    );
  }
}
