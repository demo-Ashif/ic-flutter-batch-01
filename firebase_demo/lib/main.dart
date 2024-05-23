import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/book_list_screen.dart';
import 'package:firebase_demo/firebase_messaging_service.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessagingService.initialize();
  print(await FirebaseMessagingService.getFCMToken());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}
