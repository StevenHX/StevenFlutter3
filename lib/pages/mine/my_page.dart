import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import '../../route/page/login_router.dart';
import '/route/fluro_navigator.dart';
import '../../route/page/my_router.dart';
import '../../widgets/common_views.dart';
import '../../widgets/load_image.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyPage();
  }
}

class MineItemBean {
  String iconPath;
  String title;

  MineItemBean(this.iconPath, this.title);
}

class _MyPage extends State<MyPage> {
  List<MineItemBean> mineItemList = [
    MineItemBean('collect', '我的收藏'),
    MineItemBean('night', '夜间模式'),
    MineItemBean('language', '多语言'),
    MineItemBean('about', '关于')
  ];

  @override
  void initState() {
    super.initState();
  }

  void onMyItemClick(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        NavigatorUtils.push(context, MyRouter.themePage);
        break;
      case 2:
        NavigatorUtils.push(context, MyRouter.localPage);
        break;
      case 3:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            height: 70,
            decoration: BoxDecoration(border: borderLine(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    LoadAssetImage(
                      mineItemList[0].iconPath,
                      width: 22.0,
                      height: 22.0,
                      fit: BoxFit.cover,
                    ),
                    viewSpace(width: 30),
                    Text( DeerLocalizations.of(context)!.mineTip4,
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {NavigatorUtils.push(context, MyRouter.themePage);},
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              height: 70,
              decoration: BoxDecoration(border: borderLine(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      LoadAssetImage(
                        mineItemList[1].iconPath,
                        width: 22.0,
                        height: 22.0,
                        fit: BoxFit.cover,
                      ),
                      viewSpace(width: 30),
                      Text(DeerLocalizations.of(context)!.mineTip1,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () { NavigatorUtils.push(context, MyRouter.localPage); },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              height: 70,
              decoration: BoxDecoration(border: borderLine(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      LoadAssetImage(
                        mineItemList[2].iconPath,
                        width: 22.0,
                        height: 22.0,
                        fit: BoxFit.cover,
                      ),
                      viewSpace(width: 30),
                      Text(DeerLocalizations.of(context)!.mineTip2,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            height: 70,
            decoration: BoxDecoration(border: borderLine(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    LoadAssetImage(
                      mineItemList[3].iconPath,
                      width: 22.0,
                      height: 22.0,
                      fit: BoxFit.cover,
                    ),
                    viewSpace(width: 30),
                    Text(DeerLocalizations.of(context)!.mineTip3,
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ) ;
      // return MediaQuery.removePadding(
      //     removeTop: true,
      //     context: context,
      //     child: ListView.builder(
      //       itemBuilder: (context, index) {
      //         return GestureDetector(
      //           onTap: () {
      //             onMyItemClick(index);
      //           },
      //           child: Container(
      //             margin: const EdgeInsets.only(left: 20, right: 20),
      //             padding: const EdgeInsets.only(top: 5, bottom: 5),
      //             height: 70,
      //             decoration: BoxDecoration(border: borderLine(context)),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Row(
      //                   children: [
      //                     LoadAssetImage(
      //                       mineItemList[index].iconPath,
      //                       width: 22.0,
      //                       height: 22.0,
      //                       fit: BoxFit.cover,
      //                     ),
      //                     viewSpace(width: 30),
      //                     Text(mineItemList[index].title,
      //                         style: const TextStyle(fontSize: 14)),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //       itemCount: mineItemList.length,
      //     ));
    }

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 5,
                  forceElevated: true,
                  expandedHeight: 200,
                  collapsedHeight: 75,
                  floating: true,
                  snap: false,
                  pinned: true,
                  stretch: true,
                  title: const Text('个人中心'),
                  backgroundColor: const Color.fromRGBO(31, 14, 56, 1),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    collapseMode: CollapseMode.parallax,
                    titlePadding: const EdgeInsets.only(left: 15),
                    title: GestureDetector(
                      onTap: () {  NavigatorUtils.push(context, LoginRouter.loginPage); },
                      child:  const Text("HuangXiao",
                      style: TextStyle(
                      fontSize: 22,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
                    ),
                    background: Image.network(
                      'https://t7.baidu.com/it/u=2061716906,3574604343&fm=193&f=GIF',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              )
            ];
          },
          body: SafeArea(
              top: false,
              bottom: false,
              child: Builder(builder: (BuildContext context) {
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: CustomScrollView(
                    // physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                      SliverToBoxAdapter(child: Container(child: bodyContent()))
                    ],
                  ),
                );
              }))),
    );
  }
}
