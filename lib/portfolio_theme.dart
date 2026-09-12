import 'package:flutter/material.dart';

abstract final class Palette {
  static const paper = Color(0xFFF8FAFC);
  static const white = Color(0xFFFFFFFF);
  static const ink = Color(0xFF142B42);
  static const muted = Color(0xFF5D6D7D);
  static const blue = Color(0xFF246BCE);
  static const sky = Color(0xFFE9F2FF);
  static const line = Color(0xFFDFE6ED);
  static const green = Color(0xFF21654D);
  static const mint = Color(0xFFDEF0D9);
  static const lime = Color(0xFFB9D87E);
  static const ocean = Color(0xFF183B59);
  static const water = Color(0xFF85CCEE);
  static const violet = Color(0xFFE9E3FA);
  static const purple = Color(0xFF635494);
  static const peach = Color(0xFFFFBE98);
}

abstract final class PortfolioTheme {
  static TextStyle display(double size, {Color color = Palette.ink}) =>
      TextStyle(
        fontFamily: 'Manrope',
        fontSize: size,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        height: 1.15,
        color: color,
      );

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Palette.paper,
    fontFamily: 'DM Sans',
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.blue,
      primary: Palette.blue,
      onPrimary: Palette.white,
      surface: Palette.paper,
      onSurface: Palette.ink,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, height: 1.65, color: Palette.muted),
      bodyLarge: TextStyle(fontSize: 18, height: 1.65, color: Palette.muted),
    ),
    dividerTheme: const DividerThemeData(color: Palette.line, thickness: 1),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 21),
        minimumSize: const Size(48, 52),
        textStyle: const TextStyle(
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Palette.ink,
        minimumSize: const Size(48, 52),
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 21),
        side: const BorderSide(color: Palette.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Palette.ink,
        minimumSize: const Size(48, 48),
        textStyle: const TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    tooltipTheme: const TooltipThemeData(
      waitDuration: Duration(milliseconds: 350),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Palette.ink,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

Duration motionDuration(BuildContext context, [int milliseconds = 250]) =>
    MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : Duration(milliseconds: milliseconds);
