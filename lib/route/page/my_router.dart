import 'package:fluro/fluro.dart';

import '../../pages/mine/locale_page.dart';
import '../../pages/mine/theme_page.dart';
import '../i_router.dart';


class MyRouter implements IRouterProvider{

  static String themePage = '/ThemePage';
  static String localPage = '/LocalePage';

  @override
  void initRouter(FluroRouter router) {
    router.define(themePage, handler: Handler(handlerFunc: (_, __) => const ThemePage()));
    router.define(localPage, handler: Handler(handlerFunc: (_, __) => const LocalePage()));
  }
}