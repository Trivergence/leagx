import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/authentication/components/have_account_button.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/textfield/password_textfield.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: loc.authSignupTxtSignup,
      ),
      body: SingleChildScrollView(
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    textController: _nameController,
                    hint: loc.authSignupTxtName,
                    validator: (value) {
                      if (!ValidationUtils.isValid(value)) {
                        return loc.authSignupTxtRequired;
                      }
                    },
                    prefix: const IconWidget(
                      iconData: Icons.account_circle_outlined,
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                  TextFieldWidget(
                    textController: _emailController,
                    hint: loc.authSignupTxtEmail,
                    validator: (value) {
                      if (!ValidationUtils.isValid(value)) {
                        return loc.authSignupTxtRequired;
                      }
                    },
                    prefix: const IconWidget(
                      iconData: Icons.drafts_outlined,
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                  PasswordTextField(
                    controller: _passwordController,
                    hint: loc.authSignupTxtPassword,
                  ),
                  UIHelper.verticalSpaceMedium,
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    hint: loc.authSignupTxtConfirmPassword,
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceMedium,
            MainButton(
              text: loc.authSignupBtnSignup,
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
            ),
            UIHelper.verticalSpaceMedium,
            HaveAccountButton(
              subText: loc.authSignupBtnSignin,
              onTap: () {
                Navigator.pushNamed(context, Routes.signin);
              },
            ),
          ],
        ),
      ),
    );
  }
}
