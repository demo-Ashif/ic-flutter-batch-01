import 'package:flutter/material.dart';
import 'package:swift_shop/core/extensions/context_extensions.dart';

class CoreUtils{
  static Color adaptiveColour(
      BuildContext context, {
        required Color lightModeColour,
        required Color darkModeColour,
      }) {
    return context.isDarkMode ? darkModeColour : lightModeColour;
  }
}