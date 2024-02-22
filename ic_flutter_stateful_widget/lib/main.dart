import 'package:flutter/material.dart';

import 'gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 41, 1, 147),
          Color.fromARGB(255, 167, 243, 117),
        ),
      ),
    ),
  );
}
