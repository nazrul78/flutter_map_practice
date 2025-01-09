import 'package:flutter/material.dart';
import 'package:flutter_map_practice/src/config/app_theme.dart';

class AppConfig {
  AppConfig._();
  static ThemeData themeData =
      ThemeData(useMaterial3: true, primaryColor: AppTheme.appThemeColor);
}
