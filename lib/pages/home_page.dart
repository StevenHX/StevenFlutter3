import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'package:fluttertest/pages/home/main_page.dart';
import 'package:fluttertest/pages/mine/locale_page.dart';
import 'package:fluttertest/pages/mine/my_page.dart';
import 'package:fluttertest/pages/mine/theme_page.dart';
import 'package:fluttertest/res/resources.dart';
import 'package:fluttertest/utils/theme_utils.dart';
import '../utils/device_utils.dart';
import '../utils/toast_utils.dart';
import '../widgets/load_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _lastPressedAt;
  Widget? currentPage;
  int currentIndex = 0;
  int index = 0;
  final List<Widget> _tabs = [const MainPage(), const MyPage()];

  List<BottomNavigationBarItem> _bottomTabs(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: const LoadAssetImage(
          'home',
          width: 28.0,
          height: 28.0,
          fit: BoxFit.cover,
        ),
        activeIcon: const LoadAssetImage(
          'home_press',
          width: 28.0,
          height: 28.0,
          fit: BoxFit.cover,
        ),
        label: DeerLocalizations.of(context)?.home,
      ),
      BottomNavigationBarItem(
        icon: const LoadAssetImage(
          'me',
          width: 28.0,
          height: 28.0,
          fit: BoxFit.cover,
        ),
        activeIcon: const LoadAssetImage(
          'me_press',
          width: 28.0,
          height: 28.0,
          fit: BoxFit.cover,
        ),
        label: DeerLocalizations.of(context)?.mine,
      )
    ];
  }

  /// 宽屏显示布局
  Widget widerBuildLayout(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(leading: Icon(FluentIcons.cat),title: Text("HuangXiao",style: TextStyles.textBold14,)),
      pane: NavigationPane(
          selected: index,
          onChanged: (i) => setState(() => index = i),
          displayMode: PaneDisplayMode.compact,
          size: const NavigationPaneSize(
            openWidth: 130,
          ),
          indicator: const EndNavigationIndicator(),
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.icon_sets_flag),
                title: const Text("首页"),
                body: const MainPage()),
            PaneItemSeparator(),
            PaneItem(
                icon: const Icon(FluentIcons.e_discovery),
                title: const Text("新闻"),
                body: const Text("11")),
            PaneItem(
                icon: const Icon(FluentIcons.flow_template),
                title: const Text("工具"),
                body: const Text("11")),
          ],
          footerItems: [
            PaneItem(
                icon: const Icon(FluentIcons.locale_language),
                title: const Text("语言"),
                body: const LocalePage()),
            PaneItem(
                icon: const Icon(FluentIcons.sunny),
                title: const Text("夜间模式"),
                body: const ThemePage()),
            PaneItem(
                icon: const Icon(FluentIcons.accounts),
                title: const Text("关于"),
                body: const Text("11"))
          ]),
    );
  }

  @override
  void initState() {
    super.initState();
    currentPage = _tabs[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: OrientationBuilder(builder: (context, orientation) {
        if (Device.isLargeScreen(context)) {
          return widerBuildLayout(context);
        } else {
          return Scaffold(
            body: currentPage,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: ThemeUtils.getKeyboardActionsColor(context),
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: _bottomTabs(context),
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  currentPage = _tabs[currentIndex];
                });
              },
            ),
          );
        }
      }),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          Toast.show("再按一次，退出应用！");
          return false;
        }
        return true;
      },
    );
  }
}
