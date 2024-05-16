import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/book_list_screen.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BookListScreen(),
    );
  }
}
