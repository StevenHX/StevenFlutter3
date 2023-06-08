import 'package:flutter/material.dart';
import 'package:fluttertest/pages/main_page.dart';
import 'package:fluttertest/pages/mine/my_page.dart';
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
  Widget? currentPage;
  int currentIndex = 0;
  final List<Widget> _tabs = [const MainPage(), const MyPage()];
  final List<BottomNavigationBarItem> _bottomTabs = [
     const BottomNavigationBarItem(
      icon: LoadAssetImage(
        'home',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      activeIcon: LoadAssetImage(
        'home_press',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      label: '首页',
    ),
    const BottomNavigationBarItem(
      icon: LoadAssetImage(
        'me',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      activeIcon: LoadAssetImage(
        'me_press',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      label: '我的',
    )
  ];
  @override
  void initState() {
    super.initState();
    currentPage = _tabs[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: _bottomTabs,
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
}