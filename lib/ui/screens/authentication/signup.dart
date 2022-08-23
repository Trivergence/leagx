import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/components/have_account_button.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/util/validation/validation_utils.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/password_textfield.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/textfield_widget.dart';
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
        title: 'Signup',
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
                    hint: 'Name',
                    validator: (value) {
                      if (!ValidationUtils.isValid(value)) {
                        return "required*";
                      }
                    },
                    prefix: const IconWidget(
                      iconData: Icons.account_circle_outlined,
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                  TextFieldWidget(
                    textController: _emailController,
                    hint: 'Email',
                    validator: (value) {
                      if (!ValidationUtils.isValid(value)) {
                        return "required*";
                      }
                    },
                    prefix: const IconWidget(
                      iconData: Icons.drafts_outlined,
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                  PasswordTextField(
                    controller: _passwordController,
                    hint: 'Password',
                  ),
                  UIHelper.verticalSpaceMedium,
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    hint: 'Confirm Password',
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceLarge,
            MainButton(
              text: 'Sign Up',
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
            ),
            UIHelper.verticalSpace(100.0),
            HaveAccountButton(
              subText: 'Sign In',
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
