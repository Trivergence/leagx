import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/models/auth/signin.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/authentication/components/have_account_button.dart';
import 'package:leagx/ui/screens/authentication/components/social_media_widget.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_button_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/password_textfield.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leagx/view_models/auth_view_model.dart';
import 'package:twitter_login/twitter_login.dart';

class SigninScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: loc.authSigninTxtSignin,
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
                    hint: loc.authSigninTxtEmail,
                    validator: (value) {
                      if (!ValidationUtils.isValid(value)) {
                        return loc.authSigninTxtRequired;
                      } else {
                        return ValidationUtils.email(
                            value!, loc.authSigninTxtValidEmail);
                      }
                    },
                    prefix: const IconWidget(
                      iconData: Icons.drafts_outlined,
                    ),
                    inputAction: TextInputAction.next,
                  ),
                  UIHelper.verticalSpaceMedium,
                  PasswordTextField(
                    controller: _passwordController,
                    hint: loc.authSigninTxtPassword,
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceSmall,
            Align(
              alignment: Alignment.centerRight,
              child: TextButtonWidget(
                  text: loc.authSigninBtnForgotPassword,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.forgotPassword);
                  }),
            ),
            UIHelper.verticalSpaceMedium,
            MainButton(
              text: loc.authSigninBtnSignin,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Loader.showLoader();
                  Signin? loginResponse = await AuthViewModel.login(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  Loader.hideLoader();
                  if (ValidationUtils.isValid(loginResponse)) {
                    ToastMessage.show(loc.authSigninTxtSignedinSuccessfully,
                        TOAST_TYPE.success);
                    Navigator.pushNamed(context, Routes.dashboard);
                  }
                }
              },
            ),
            UIHelper.verticalSpaceMedium,
            TextWidget(
              text: loc.authSigninTxtSocialAccounts,
              color: AppColors.colorGrey,
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaWidget(
                  iconData: FontAwesomeIcons.apple,
                  onTap: () {},
                ),
                UIHelper.horizontalSpaceMedium,
                // SocialMediaWidget(iconData: FontAwesomeIcons.facebookF),
                // UIHelper.horizontalSpaceMedium,
                SocialMediaWidget(
                  iconData: FontAwesomeIcons.twitter,
                  onTap: () async {
                    final twitterLogin = TwitterLogin(
                      apiKey: Strings.apiKeyTwitter,
                      apiSecretKey: Strings.apiSecretKeyTwitter,
                      redirectURI: Strings.redirectUriTwitter,
                    );
                    final authResult = await twitterLogin.loginV2();
                    switch (authResult.status) {
                      case TwitterLoginStatus.loggedIn:
                        print('logged in');
                        break;
                      case TwitterLoginStatus.cancelledByUser:
                        print('====== Login cancel ======');
                        break;
                      case TwitterLoginStatus.error:
                      case null:
                        print('====== Login error ======');
                        break;
                    }
                  },
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            HaveAccountButton(
              subText: loc.authSigninBtnSignup,
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
