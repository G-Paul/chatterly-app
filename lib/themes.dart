import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightThemes {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFD446E),
      secondary: Color(0xFFFAC949),
      background: Color.fromARGB(255, 255, 253, 230),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.black,
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.ralewayTextTheme(),
  );
}

class DarkThemes {
  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFD446E),
        secondary: Color(0xFFFAC949),
        background: Color.fromARGB(255, 255, 253, 230)),
    useMaterial3: true,
  );
}
