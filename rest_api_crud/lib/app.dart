import 'package:flutter/material.dart';
import 'package:rest_api_crud/ad_list_screen.dart';

class RestCrudApp extends StatelessWidget {
  RestCrudApp({super.key});

  // Define a common border style
  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromRGBO(198, 0, 74, 1.0),
        inputDecorationTheme: InputDecorationTheme(
          border: borderStyle,
          enabledBorder: borderStyle,
          focusedBorder: borderStyle,
          errorBorder: borderStyle,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const AdListScreen(),
    );
  }
}
