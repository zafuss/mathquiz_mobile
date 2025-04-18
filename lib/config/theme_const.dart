import 'package:flutter/material.dart';
import 'package:mathquiz_mobile/config/color_const.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      colorSchemeSeed: ColorPalette.primaryColor,
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      // colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        textStyle:
            WidgetStateProperty.all<TextStyle>(const TextStyle(fontSize: 16)),
        alignment: Alignment.center,
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            ColorPalette.primaryColor,
          ),
          minimumSize:
              WidgetStateProperty.all<Size>(const Size(double.infinity, 53.0)),
          foregroundColor: WidgetStateProperty.all<Color>(
            Colors.white,
          ),
        ),
      ),
      // inputDecorationTheme: const InputDecorationTheme(
      //   focusedBorder:
      // ),

      buttonTheme: ButtonThemeData(
        height: 53,
        minWidth: 293,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      scaffoldBackgroundColor: const Color.fromRGBO(228, 237, 243, 1),
      useMaterial3: true,
    );
  }

  // static ThemeData darkTheme() {
  //   return ThemeData(
  //     // Define the primary color for your dark theme
  //     primaryColor: Colors.grey[800],
  //     // Define the accent color for your dark theme
  //     accentColor: Colors.tealAccent,
  //     // Define the text theme for your dark theme
  //     textTheme: TextTheme(
  //       headline1: TextStyle(
  //           fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
  //       bodyText1: TextStyle(fontSize: 16, color: Colors.white),
  //     ),
  //     // Define other properties of the theme as needed
  //     // For example, you can set the brightness, scaffoldBackgroundColor, etc.
  //   );
  // }
}
