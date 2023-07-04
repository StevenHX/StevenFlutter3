import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide DividerThemeData;
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';
import '../res/constant.dart';
import '../res/resources.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {

  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode(){
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    switch(theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  FluentThemeData getTheme({bool isDarkMode = false}) {
    return FluentThemeData(
      accentColor: AccentColor.swatch(const <String, Color>{
        'darkest': Color(0xff004a83),
        'darker': Color(0xff005494),
        'dark': Color(0xff0066b4),
        'normal': Color(0xff0078d4),
        'light': Color(0xff268cda),
        'lighter': Color(0xff4ca0e0),
        'lightest': Color(0xff60abe4),
        }),
      brightness: isDarkMode ? Brightness.dark: Brightness.light,
      ///页面背景色
      scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
      dividerTheme: DividerThemeData(
        decoration: BoxDecoration(color: isDarkMode ? Colours.dark_line : Colours.line),
        thickness: 0.6
      ),
    );
  }

}