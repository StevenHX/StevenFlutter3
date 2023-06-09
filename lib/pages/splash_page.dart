import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertest/route/page/home_router.dart';
import 'package:fluttertest/utils/image_utils.dart';
import '../route/fluro_navigator.dart';
import '../widgets/load_image.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i).take(3).listen((int i) {
      print(i);
      if (i == 3 - 1) {
        NavigatorUtils.push(context, HomeRouter.homePage, replace: true);
        _subscription?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(), // 自适应屏幕
        child: const LoadAssetImage("splash",fit: BoxFit.fill,format: ImageFormat.jpg,)
      );
  }
}
