import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    // Use one of your extracted oranges/browns as the primary accent
    primaryColor: const Color(0xFF482B1C), // earthy warm tone

    scaffoldBackgroundColor: Colors.transparent, // handled by gradient in Scaffold

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // --text-primary
      bodyMedium: TextStyle(color: Color(0xFFBCAAA4)), // warm beige secondary
    ),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF482B1C), // main brand tone
      secondary: Color(0xFF503418), // accent pulled from palette
      surface: Color(0xFF371929), // deep surface tone
    ),

    cardColor: const Color.fromRGBO(64, 43, 21, 0.6), // frosted glass-like from #402B15
    dividerColor: const Color.fromRGBO(255, 255, 255, 0.2), // soft divider
  );

  // Your gradient for Scaffold backgrounds
  static const List<Color> gradientColors = [
    Color(0xFF482B1C),
    Color(0xFF4D3019),
    Color(0xFF371929),
    Color(0xFF422C15),
    Color(0xFF503418),
    Color(0xFF46281D),
    Color(0xFF3E2122),
    Color(0xFF402B15),
  ];
}
