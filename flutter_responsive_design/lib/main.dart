import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveLayout(),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using LayoutBuilder to build a layout dynamically based on the parent widget's constraints
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if the width is more than 600 pixels, if so, use a two-column layout
        if (constraints.maxWidth > 600) {
          return TwoColumnLayout();
        } else {
          // Otherwise, use a one-column layout
          return OneColumnLayout();
        }
      },
    );
  }
}

class OneColumnLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('One Column Layout'),
    );
  }
}

class TwoColumnLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text('Left Column'),
          ),
        ),
        Expanded(
          child: Center(
            child: Text('Right Column'),
          ),
        ),
      ],
    );
  }
}
