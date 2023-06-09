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


/// design/1注册登录/index.html#artboard9
class ResetPasswordPage extends StatefulWidget {

  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with ChangeNotifierMixin<ResetPasswordPage> {
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

  void _reset() {
    Toast.show(DeerLocalizations.of(context)!.confirm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: DeerLocalizations.of(context)!.forgotPasswordLink,
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
        DeerLocalizations.of(context)!.resetLoginPassword,
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        focusNode: _nodeText1,
        controller: _nameController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: DeerLocalizations.of(context)!.inputPhoneHint,
      ),
      Gaps.vGap8,
      MyTextField(
        focusNode: _nodeText2,
        controller: _vCodeController,
        keyboardType: TextInputType.number,
        getVCode: () {
          return Future<bool>.value(true);
        },
        maxLength: 6,
        hintText: DeerLocalizations.of(context)!.inputVerificationCodeHint,
      ),
      Gaps.vGap8,
      MyTextField(
        focusNode: _nodeText3,
        isInputPwd: true,
        controller: _passwordController,
        maxLength: 16,
        keyboardType: TextInputType.visiblePassword,
        hintText: DeerLocalizations.of(context)!.inputPasswordHint,
      ),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _reset : null,
        text: DeerLocalizations.of(context)!.confirm,
      )
    ];
  }
}
