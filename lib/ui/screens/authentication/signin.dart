import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/components/have_account_button.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/components/social_media_widget.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/util/validation/validation_utils.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_button_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/password_textfield.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninScreen extends StatelessWidget {
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: 'Sign In',
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
                    textController: _emailController,
                    hint: 'Email',
                    validator: (value) {
                      if (!ValidationUtils.isValid(value)) {
                        return "required*";
                      }
                      return null;
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
                ],
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Align(
              alignment: Alignment.centerRight,
              child: TextButtonWidget(
                  text: 'Forgot Password ?',
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.forgotPassword);
                  }),
            ),
            UIHelper.verticalSpaceLarge,
            MainButton(
              text: 'Sign In',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, Routes.dashboard);
                }
              },
            ),
            UIHelper.verticalSpaceXL,
            const TextWidget(
              text: 'Or by social accounts',
              color: AppColors.colorGrey,
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SocialMediaWidget(iconData: FontAwesomeIcons.apple),
                UIHelper.horizontalSpaceMedium,
                // SocialMediaWidget(iconData: FontAwesomeIcons.facebookF),
                // UIHelper.horizontalSpaceMedium,
                SocialMediaWidget(iconData: FontAwesomeIcons.twitter),
              ],
            ),
            UIHelper.verticalSpace(100.0),
            HaveAccountButton(
              subText: 'Sign Up',
              onTap: () {
                Navigator.pushNamed(context, Routes.signup);
              },
            ),
          ],
        ),
      ),
    );
  }
}
