import 'package:fluro/fluro.dart';
import 'package:fluttertest/pages/home_page.dart';
import '../i_router.dart';


class HomeRouter implements IRouterProvider{

  static String homePage = '/home';

  @override
  void initRouter(FluroRouter router) {
    router.define(homePage, handler: Handler(handlerFunc: (_, __) => const MyHomePage()));
  }
}