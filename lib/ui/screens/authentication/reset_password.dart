import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/core/network/internet_info.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui/validation_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/auth_view_model.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ResetPasswordScreen({Key? key}) : super(key: key);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: loc.authResetPasswordTxtResetPassword,
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontalPadding,
            vertical: Dimens.verticalPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIHelper.verticalSpaceLarge,
                Image.asset(Assets.appLogo),
                UIHelper.verticalSpaceXL,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.horizontalSpaceMedium),
                  child: TextWidget(
                    text: loc.authResetPasswordTxtCheckEmailDes,
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpaceLarge,
                PasswordTextField(
                  inputAction: TextInputAction.next,
                  controller: _passwordController,
                  validator: (text) => ValidationHelper.validatePassword(text),
                  hint: loc.authResetPasswordTxtPassword),
                UIHelper.verticalSpaceMedium,
                PasswordTextField(
                  controller: _confirmPasswordController,
                  validator: (text) => ValidationHelper.validatePassword(text),
                  hint: loc.authResetPasswordTxtConfirmPassword,
                ),
                UIHelper.verticalSpaceLarge,
                MainButton(
                  text: loc.authResetPasswordBtnResetPassword,
                  onPressed: changePassword,
                ),
                /*UIHelper.verticalSpace(100.0),
                HaveAccountButton(
                  subText: 'Sign Up',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.signup);
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changePassword() async {
    if(_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        bool isConnected = await InternetInfo.isConnected();
        if (isConnected == true) {
          bool success = await AuthViewModel.changePassword(
              password: _passwordController.text);
          if (success == true) {
            Navigator.of(_context).pop();
          }
        }
      } else {
        ToastMessage.show(loc.authResetPasswordSameMsg, TOAST_TYPE.msg);
      }
    }
  }
}
