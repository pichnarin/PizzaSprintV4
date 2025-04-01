import 'package:flutter/material.dart';

///
/// Definition of App colors.
///
class PizzaColors {
  static Color primary = const Color(0xFFE53935); // Red for pizza theme
  static Color secondary = const Color(0xFFFFB74D); // Warm orange for accents
  static Color backgroundAccent = const Color(0xFFF5F5F5);
  
  static Color neutralDark = const Color(0xFF333333);
  static Color neutral = const Color(0xFF555555);
  static Color neutralLight = const Color(0xFF888888);
  static Color neutralLighter = const Color(0xFFBBBBBB);

  static Color greyLight = const Color(0xFFE2E2E2);
  static Color white = Colors.white;

  static var background;

  static Color get backGroundColor { 
    return PizzaColors.primary;
  }

  static Color get textNormal {
    return PizzaColors.neutralDark;
  }

  static Color get textLight {
    return PizzaColors.neutralLight;
  }

  static Color get iconNormal {
    return PizzaColors.neutral;
  }

  static Color get iconLight {
    return PizzaColors.neutralLighter;
  }

  static Color get disabled {
    return PizzaColors.greyLight;
  }
}
  
///
/// Definition of App text styles.
///
class PizzaTextStyles {
  static TextStyle heading = const TextStyle(fontSize: 28, fontWeight: FontWeight.w500, fontFamily: 'Poppins');
  static TextStyle body = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Poppins');
  static TextStyle label = const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'Poppins');
  static TextStyle button = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins');
}

///
/// Definition of App spacings, in pixels.
///
class PizzaSpacings {
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 40;

  static const double radius = 12;
  static const double radiusLarge = 20;
}

///
/// Definition of App Theme.
///
ThemeData pizzaTheme = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: PizzaColors.backgroundAccent,
  primaryColor: PizzaColors.primary,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: PizzaColors.secondary,
  ),
  textTheme: TextTheme(
    bodyLarge: PizzaTextStyles.body,
    bodyMedium: PizzaTextStyles.label,
    titleLarge: PizzaTextStyles.heading,
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PizzaSpacings.radius)),
    buttonColor: PizzaColors.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: PizzaColors.white, backgroundColor: PizzaColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PizzaSpacings.radius)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(PizzaSpacings.radius)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: PizzaColors.primary)),
  ),
);