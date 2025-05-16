import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getAppBarTextStyle(BuildContext context) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle getTextStyle(
  BuildContext context,
  double fontSize,
  FontWeight fontWeight,
  Color color,
  TextDecoration? decoration,
  FontStyle fontStyle,
) {
  return GoogleFonts.inter(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    decoration: decoration,
    decorationColor: color,
    decorationThickness: 2.0,
    fontStyle: fontStyle,
  );
}

TextStyle getHintTextStyle(BuildContext context) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      color: Colors.grey[500],
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}

TextStyle getInputTextStyle(BuildContext context) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}

TextStyle getDisabledInputTextStyle(BuildContext context) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}
