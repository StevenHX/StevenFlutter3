import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:sp_util/sp_util.dart';

import '../../res/constant.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import '../../route/fluro_navigator.dart';
import '../../route/page/login_router.dart';
import '../../utils/change_notifier_manage.dart';
import '../../utils/theme_utils.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_scroll_view.dart';
import '../../widgets/my_text_field.dart';


/// design/1注册登录/index.html
class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifierMixin<LoginPage> {
  //定义一个controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 显示状态栏和导航栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
    _nameController.text = SpUtil.getString(Constant.phone)!;
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {
    SpUtil.putString(Constant.phone, _nameController.text);
    // NavigatorUtils.push(context, StoreRouter.auditPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: DeerLocalizations.of(context)!.verificationCodeLogin,
        onPressed: () {
          NavigatorUtils.push(context, LoginRouter.smsLoginPage);
        },
      ),
      body: MyScrollView(
        keyboardConfig: KeyboardActionsConfig(
          keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
          nextFocus: true,
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody,
      ),
    );
  }

  List<Widget> get _buildBody => <Widget>[
    Text(
      DeerLocalizations.of(context)!.passwordLogin,
      style: TextStyles.textBold26,
    ),
    Gaps.vGap16,
    MyTextField(
      key: const Key('phone'),
      focusNode: _nodeText1,
      controller: _nameController,
      maxLength: 11,
      keyboardType: TextInputType.phone,
      hintText: DeerLocalizations.of(context)!.inputUsernameHint,
    ),
    Gaps.vGap8,
    MyTextField(
      key: const Key('password'),
      keyName: 'password',
      focusNode: _nodeText2,
      isInputPwd: true,
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      maxLength: 16,
      hintText: DeerLocalizations.of(context)!.inputPasswordHint,
    ),
    Gaps.vGap24,
    MyButton(
      key: const Key('login'),
      onPressed: _clickable ? _login : null,
      text: DeerLocalizations.of(context)!.login,
    ),
    Container(
      height: 40.0,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          DeerLocalizations.of(context)!.forgotPasswordLink,
          key: const Key('forgotPassword'),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
      ),
    ),
    Gaps.vGap16,
    Container(
      alignment: Alignment.center,
      child: GestureDetector(
        child: Text(
          DeerLocalizations.of(context)!.noAccountRegisterLink,
          key: const Key('noAccountRegister'),
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
        onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
      )
    )
  ];
}
