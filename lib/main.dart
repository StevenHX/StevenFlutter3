import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/material.dart';
import 'package:fluttertest/pages/splash_page.dart';
import 'package:sp_util/sp_util.dart';
import 'provider/locale_provider.dart';
import 'provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'route/routers.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // DateTime? _lastPressedAt;
  MyApp({Key? key}): super(key: key) {
    Routes.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    final Widget app = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider())
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (_, ThemeProvider provider, LocaleProvider localeProvider, __) {
          return buildApp(provider,localeProvider);
        },
      ),
    );
    return OKToast(
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      child: app,
    );
  }

  Widget buildApp(ThemeProvider provider, LocaleProvider localeProvider) {
    return FluentApp(
      title: 'Flutter Demo',
      theme: provider.getTheme(),
      darkTheme: provider.getTheme(isDarkMode: true),
      themeMode: provider.getThemeMode(),
      onGenerateRoute: Routes.router.generator,
      localizationsDelegates: DeerLocalizations.localizationsDelegates,
      supportedLocales: DeerLocalizations.supportedLocales,
      locale: localeProvider.locale,
      builder: (BuildContext context, Widget? child) {
        /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: const SplashPage()
    );
  }
}