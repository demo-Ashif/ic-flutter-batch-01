import 'package:flutter/material.dart';
import 'package:rest_api_ui/ad_list_screen.dart';

final OutlineInputBorder borderStyle =
    OutlineInputBorder(borderRadius: BorderRadius.circular(16));

class RestCrudApp extends StatelessWidget {
  const RestCrudApp({super.key});

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
              fontWeight: FontWeight.w600
            )
          )
        )
      ),
      home: const AdListScreen(),
    );
  }
}
