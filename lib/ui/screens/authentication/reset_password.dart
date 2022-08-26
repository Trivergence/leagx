import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/components/have_account_button.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/password_textfield.dart';
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
        title: 'Reset Password',
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
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalSpaceMedium),
                child: TextWidget(
                  text:
                      'Check your email or phone number to retrieve your password.',
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpaceLarge,
              PasswordTextField(
                  controller: _passwordController, hint: 'Password'),
              UIHelper.verticalSpaceMedium,
              PasswordTextField(
                controller: _confirmPasswordController,
                hint: 'Confirm Password',
              ),
              UIHelper.verticalSpaceLarge,
              MainButton(
                text: 'Reset Password',
                onPressed: () {

                },
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
