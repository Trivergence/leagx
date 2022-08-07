import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/components/have_account_button.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
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
            TextFieldWidget(
              textController: _emailController,
              hint: 'Email',
              validator: () {},
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButtonWidget(text: 'Forgot Password ?', onPressed: () {
                Navigator.pushNamed(context, Routes.forgotPassword);
              }),
            ),
            UIHelper.verticalSpaceLarge,
            MainButton(
              text: 'Sign In',
              onPressed: () {},
            ),
            UIHelper.verticalSpaceXL,
            const TextWidget(
              text: 'Or by social accounts',
              color: AppColors.colorGrey,
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0085FF),
                          Color(0xFF00417C),
                        ],
                      ),
                    ),
                    child: const IconWidget(
                      iconData: FontAwesomeIcons.apple,
                      // color: Colors.white,
                    ),
                  ),
                ),
                UIHelper.horizontalSpaceMedium,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3B5998),
                          Color(0xFF2C61CF),
                        ],
                      ),
                    ),
                    child: const IconWidget(
                      iconData: FontAwesomeIcons.facebookF,
                      // color: Colors.white,
                    ),
                  ),
                ),
                UIHelper.horizontalSpaceMedium,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1DA1F2),
                          Color(0xFF006DAF),
                        ],
                      ),
                    ),
                    child: const IconWidget(iconData: FontAwesomeIcons.twitter
                        // color: Colors.white,
                        ),
                  ),
                ),
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
