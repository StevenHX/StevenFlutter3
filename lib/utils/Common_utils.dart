
import 'package:sp_util/sp_util.dart';

import '../res/constant.dart';

/// 通用工具类
class Utils {
  static String? getCurrLocale() {
    final String locale = SpUtil.getString(Constant.locale)!;
    // if (locale == '') {
    //   return window.locale.languageCode;
    // }
    return locale;
  }
}