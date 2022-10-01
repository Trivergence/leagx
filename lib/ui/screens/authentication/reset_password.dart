import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/password_textfield.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                hint: loc.authResetPasswordTxtPassword),
              UIHelper.verticalSpaceMedium,
              PasswordTextField(
                controller: _confirmPasswordController,
                hint: loc.authResetPasswordTxtConfirmPassword,
              ),
              UIHelper.verticalSpaceLarge,
              MainButton(
                text: loc.authResetPasswordBtnResetPassword,
                onPressed: () {},
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
    );
  }
}
