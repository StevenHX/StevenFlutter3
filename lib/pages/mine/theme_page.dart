import 'package:flutter/material.dart';
import 'package:fluttertest/utils/device_utils.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../../provider/theme_provider.dart';
import '../../res/constant.dart';
import '../../utils/theme_utils.dart';
import '../../widgets/my_app_bar.dart';

class ThemePage extends StatefulWidget {

  const ThemePage({Key? key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  final List<String> _list = <String>['跟随系统', '开启', '关闭'];

  @override
  Widget build(BuildContext context) {
    final String? theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch(theme) {
      case 'Dark':
        themeMode = _list[1];
        break;
      case 'Light':
        themeMode = _list[2];
        break;
      default:
        themeMode = _list[0];
        break;
    }
    return Scaffold(
      backgroundColor: ThemeUtils.getKeyboardActionsColor(context),
      appBar: MyAppBar(
        title: '夜间模式',
        isBack: !Device.isLargeScreen(context),
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              final ThemeMode themeMode = index == 0 ? ThemeMode.system : (index == 1 ? ThemeMode.dark : ThemeMode.light);
              context.read<ThemeProvider>().setTheme(themeMode);
              setState(() {});
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_list[index]),
                  ),
                  Opacity(
                    opacity: themeMode == _list[index] ? 1 : 0,
                    child: const Icon(Icons.done, color: Colors.blue),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
