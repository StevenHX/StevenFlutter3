import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class Device {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;
  static bool get isLinux => !isWeb && Platform.isLinux;
  static bool get isMacOS => !isWeb && Platform.isMacOS;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isFuchsia => !isWeb && Platform.isFuchsia;
  static bool get isIOS => !isWeb && Platform.isIOS;

  /// 判断界面是不是 大屏
  static isLargeScreen(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double width = size.width > size.height ? size.height : size.width;
    // print(width);
    // print(MediaQuery.of(context).orientation);
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}