import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

import '../../res/gaps.dart';
import '../../res/styles.dart';
import '../../utils/change_notifier_manage.dart';
import '../../utils/theme_utils.dart';
import '../../utils/toast_utils.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_scroll_view.dart';
import '../../widgets/my_text_field.dart';

/// design/1注册登录/index.html#artboard11
class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ChangeNotifierMixin<RegisterPage> {
  //定义一个controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _vCodeController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
      _nodeText3: null,
    };
  }

  void _verify() {
    final String name = _nameController.text;
    final String vCode = _vCodeController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _register() {
    Toast.show('点击注册');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: DeerLocalizations.of(context)!.register,
        ),
        body: MyScrollView(
          keyboardConfig: KeyboardActionsConfig(
            keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
            nextFocus: true,
          ),
          crossAxisAlignment: CrossAxisAlignment.center,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          children: _buildBody(),
        ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Text(
        DeerLocalizations.of(context)!.openYourAccount,
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        key: const Key('phone'),
        focusNode: _nodeText1,
        controller: _nameController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: DeerLocalizations.of(context)!.inputPhoneHint,
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('vcode'),
        focusNode: _nodeText2,
        controller: _vCodeController,
        keyboardType: TextInputType.number,
        getVCode: () async {
          if (_nameController.text.length == 11) {
            Toast.show(DeerLocalizations.of(context)!.verificationButton);
            /// 一般可以在这里发送真正的请求，请求成功返回true
            return true;
          } else {
            Toast.show(DeerLocalizations.of(context)!.inputPhoneInvalid);
            return false;
          }
        },
        maxLength: 6,
        hintText: DeerLocalizations.of(context)!.inputVerificationCodeHint,
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('password'),
        keyName: 'password',
        focusNode: _nodeText3,
        isInputPwd: true,
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        maxLength: 16,
        hintText: DeerLocalizations.of(context)!.inputPasswordHint,
      ),
      Gaps.vGap24,
      MyButton(
        key: const Key('register'),
        onPressed: _clickable ? _register : null,
        text: DeerLocalizations.of(context)!.register,
      )
    ];
  }
}
