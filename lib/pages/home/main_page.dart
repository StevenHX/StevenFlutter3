import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/pages/home/DownloadController.dart';
import 'package:fluttertest/widgets/download_button.dart';

import '../../http/dio_method.dart';
import '../../http/dio_response.dart';
import '../../http/dio_util.dart';
import '../../model/banner_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;
  final CancelToken _cancelToken = CancelToken();

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  late final DownloadController downloadController;

  @override
  void initState() {
    super.initState();
    downloadController = DownloadController(onOpenDownload: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'flutter',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            OrientationBuilder(
              builder: (context, orientation) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(animation: downloadController, builder: (context, child) {
                        return  DownloadButton(
                            status: downloadController.downloadStatus,
                            downloadProgress: downloadController.progress,
                            onDownload: downloadController.startDownload,
                            onOpen: downloadController.openDownload,
                            onCancel: downloadController.stopDownload);
                      }),
                    ],
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Text(
                    '点击登录，即表示以阅读并同意',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromRGBO(153, 153, 153, 1)),
                  ),
                   InkWell(
                    child: Text(
                      '《会员服务条款》',
                      style: TextStyle(
                          color: Color.fromRGBO(85, 122, 157, 1), fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () async {
                  DioUtil.getInstance()?.openLog();
                  DioResponse response = await DioUtil().request("/banner/json",
                      method: DioMethod.get, cancelToken: _cancelToken);
                  BannerModel banner = BannerModel.fromJson(response.data);
                  print(banner.toString());
                },
                child: const Text(
                  "提交",
                  style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
