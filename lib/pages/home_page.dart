import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'package:fluttertest/pages/home/main_page.dart';
import 'package:fluttertest/pages/mine/my_page.dart';
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

  @override
  void initState() {
    super.initState();
    currentPage = _tabs[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        child: Scaffold(
          body: currentPage,
          bottomNavigationBar: BottomNavigationBar(
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
        ),
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
