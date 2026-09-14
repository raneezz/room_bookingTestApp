import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.orange,
      brightness: Brightness.dark,
    ),
    fontFamily: 'Roboto',
  );
}
