import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../res/constant.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? get locale {
    // final String locale = SpUtil.getString(Constant.locale) ?? '';
    final String locale = '';
    switch (locale) {
      case 'zh':
        return const Locale('zh', 'CN');
      case 'en':
        return const Locale('en', 'US');
      default:
        return null;
    }
  }

  void setLocale(String locale) {
    // SpUtil.putString(Constant.locale, locale);
    // print(SpUtil.getString(Constant.locale));
    notifyListeners();
  }
}
