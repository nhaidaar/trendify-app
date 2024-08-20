import 'package:flutter/material.dart';

TextTheme createTextTheme(BuildContext context, String bodyFontFamily) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme textTheme = baseTextTheme.copyWith(
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontFamily: bodyFontFamily),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontFamily: bodyFontFamily),
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontFamily: bodyFontFamily),
    labelLarge: baseTextTheme.labelLarge?.copyWith(fontFamily: bodyFontFamily),
    labelMedium: baseTextTheme.labelMedium?.copyWith(fontFamily: bodyFontFamily),
    labelSmall: baseTextTheme.labelSmall?.copyWith(fontFamily: bodyFontFamily),
  );
  return textTheme;
}
