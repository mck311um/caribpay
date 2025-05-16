import 'package:flutter/material.dart';

class CustomColors {
  static const Color turquoise = Color(0xFF0EA5E9);
  static const Color coral = Color(0xFFF97316);
  static const Color sand = Color(0xFFF5E1B5);
  static const Color sunrise = Color(0xFFFF8B64);
  static const Color seafoam = Color(0xFF90E0C5);
  static const Color navy = Color(0xFF1E40AF);
  static const Color lagoon = Color(0xFF38BDF8);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0EA5E9),
  onPrimary: Color(0xFFF0F9FF),
  primaryContainer: Color(0xFF0C96D8),
  onPrimaryContainer: Color(0xFFF0F9FF),
  secondary: Color(0xFFFFB86C),
  onSecondary: Color(0xFF0F172A),
  secondaryContainer: Color(0xFFE69E5D),
  onSecondaryContainer: Color(0xFF0F172A),
  tertiary: Color(0xFF6D3BC6),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF5D2DAD),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: Color(0xFFEF4444),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFDC2626),
  onErrorContainer: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF1E293B),
  onSurfaceVariant: Color(0xFF64748B),
  outline: Color(0xFFE2E8F0),
  shadow: Color(0xFF000000),
  inverseSurface: Color(0xFF1E293B),
  onInverseSurface: Color(0xFFF1F5F9),
  inversePrimary: Color(0xFFBAE6FD),
  surfaceTint: Color(0xFF0EA5E9),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF38BDF8),
  onPrimary: Color(0xFF082F49),
  primaryContainer: Color(0xFF0C4A6E),
  onPrimaryContainer: Color(0xFFE0F2FE),
  secondary: Color(0xFFF59E0B),
  onSecondary: Color(0xFF422006),
  secondaryContainer: Color(0xFFB45309),
  onSecondaryContainer: Color(0xFFFEF3C7),
  tertiary: Color(0xFF8B5CF6),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF6D28D9),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: Color(0xFFF87171),
  onError: Color(0xFF450A0A),
  errorContainer: Color(0xFFB91C1C),
  onErrorContainer: Color(0xFFFEE2E2),
  surface: Color(0xFF0F172A),
  onSurface: Color(0xFFE2E8F0),
  onSurfaceVariant: Color(0xFF94A3B8),
  outline: Color(0xFF334155),
  shadow: Color(0xFF000000),
  inverseSurface: Color(0xFFE2E8F0),
  onInverseSurface: Color(0xFF1E293B),
  inversePrimary: Color(0xFF0369A1),
  surfaceTint: Color(0xFF38BDF8),
);
