import 'package:flutter/material.dart';
import 'package:ic_flutter_batch_first_app/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //Route -> We have to go
  //Navigator  -> Will help us to Go
  //Navigation

  ///Routing/Navigation steps
  ///Step 1: Tell Where you are
  ///Step 2: Tell Where you want to go
  ///Step 3: Go using Navigator (Flutter)
  ///Navigator methods
  ///
  /// push,pop,pushReplacement,pushAndRemoveUntil
  /// pushNamed, pushReplaceNamed
  /// routes {}, initial route
  /// Libraries: AutoRoute, GoRouter, Navigator 2

  ///Data passing via Constructor  (Efficient, Readable)
  ///Data passing via Arguments (Self study)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      profileName: 'Ashif',
                    ),
                  ),
                );
              },
              child: Text('Go To Profile'),
            )
          ],
        ),
      ),
    );
  }
}
