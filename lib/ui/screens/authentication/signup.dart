import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/models/user/user.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/authentication/components/have_account_button.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/textfield/password_textfield.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/auth_view_model.dart';

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
                    inputAction: TextInputAction.next,
                    
                  ),
                  UIHelper.verticalSpaceMedium,
                  TextFieldWidget(
                    textController: _emailController,
                    hint: loc.authSignupTxtEmail,
                    validator: (value) {
                      if (!ValidationUtils.isValid(value)) {
                        return loc.authSignupTxtRequired;
                      } else {
                        return ValidationUtils.email(
                            value!, loc.authSignupTxtValidEmail);
                      }
                    },
                    prefix: const IconWidget(
                      iconData: Icons.drafts_outlined,
                    ),
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                  ),
                  UIHelper.verticalSpaceMedium,
                  PasswordTextField(
                    controller: _passwordController,
                    hint: loc.authSignupTxtPassword,
                    inputAction: TextInputAction.next,
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    Loader.showLoader();
                    User? signupResponse = await AuthViewModel.signup(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text,
                    );
                    Loader.hideLoader();
                    if (ValidationUtils.isValid(signupResponse)) {
                      ToastMessage.show(
                          loc.authSignupTxtSignedupSuccessfully, TOAST_TYPE.success);
                      Navigator.pushNamed(context, Routes.signin);
                    }
                  } else {
                    ToastMessage.show(
                        "Password doesn't match", TOAST_TYPE.error);
                  }
                }
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
