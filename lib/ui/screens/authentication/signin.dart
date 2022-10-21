import 'dart:io';

import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/core/network/internet_info.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/models/user/user.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/authentication/components/have_account_button.dart';
import 'package:leagx/ui/screens/authentication/components/social_media_widget.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui/validation_helper.dart';
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
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:payments/payments.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

class SigninScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Localization.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: loc.authSigninTxtSignin,
        hasBackButton: false,
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
                    validator: (value) => ValidationHelper.validateEmail(value),
                    prefix: const IconWidget(
                      iconData: Icons.drafts_outlined,
                    ),
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                  ),
                  UIHelper.verticalSpaceMedium,
                  PasswordTextField(
                    controller: _passwordController,
                    hint: loc.authSigninTxtPassword,
                    inputAction: TextInputAction.done,
                    validator: (value) =>
                        ValidationHelper.validatePassword(value),
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
                bool isConnected = await InternetInfo.isConnected();
                if (isConnected) {
                  if (_formKey.currentState!.validate()) {
                    Loader.showLoader();
                    User? userData = await AuthViewModel.login(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    Loader.hideLoader();

                    if (ValidationUtils.isValid(userData)) {
                      preferenceHelper.saveAuthToken(userData!.apiToken);
                      preferenceHelper.saveUser(userData);
                      DashBoardViewModel dashBoardModel =
                          context.read<DashBoardViewModel>();
                      await dashBoardModel.getSubscribedLeagues();
                      if (dashBoardModel.subscribedLeagues.isEmpty) {
                        AuthViewModel.subscribeOneLeague(userData.id);
                      }
                      ToastMessage.show(loc.authSigninTxtSignedinSuccessfully,
                          TOAST_TYPE.success);
                      Navigator.pushNamed(context, Routes.dashboard);
                    }
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
                if (Platform.isIOS)
                  SocialMediaWidget(
                    iconData: FontAwesomeIcons.apple,
                    onTap: () => _logInWithApple(context),
                  ),
                UIHelper.horizontalSpaceMedium,
                // SocialMediaWidget(iconData: FontAwesomeIcons.facebookF),
                // UIHelper.horizontalSpaceMedium,
                SocialMediaWidget(
                  iconData: FontAwesomeIcons.twitter,
                  onTap: () async {
                    await _loginWithTwitter(context);
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

  _loginWithTwitter(BuildContext context) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected) {
      final twitterLogin = TwitterLogin(
        apiKey: Strings.apiKeyTwitter,
        apiSecretKey: Strings.apiSecretKeyTwitter,
        redirectURI: Strings.redirectUriTwitter,
      );
      final authResult = await twitterLogin.loginV2();
      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          User? user = await AuthViewModel.twitterLogin(
              authType: AuthType.twitter, user: authResult.user!);
          if (ValidationUtils.isValid(user)) {
            preferenceHelper.saveAuthToken(user!.apiToken);
            preferenceHelper.saveUser(user);
            ToastMessage.show(loc.authSigninTxtLoggedin, TOAST_TYPE.success);
            Navigator.pushNamed(context, Routes.dashboard);
            context.read<DashBoardViewModel>().getPaymentCredentials(context);
          }
          break;
        case TwitterLoginStatus.cancelledByUser:
          ToastMessage.show(loc.authSigninTxtCancelledByUser, TOAST_TYPE.msg);
          break;
        case TwitterLoginStatus.error:
          ToastMessage.show(authResult.errorMessage!, TOAST_TYPE.error);
          break;
        case null:
          ToastMessage.show(
              loc.authSigninTxtNothingToProceed, TOAST_TYPE.error);
          break;
      }
    }
  }

  Future<void> _logInWithApple(BuildContext context) async {
    bool isAvailable = await SignInWithApple.isAvailable();
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected) {
      if (isAvailable) {
        try {
          AuthorizationCredentialAppleID credential =
              await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          User? user = await AuthViewModel.appleLogin(
              authType: AuthType.apple, userCredentials: credential);
          if (ValidationUtils.isValid(user)) {
            preferenceHelper.saveAuthToken(user!.apiToken);
            preferenceHelper.saveUser(user);
            ToastMessage.show(loc.authSigninTxtLoggedin, TOAST_TYPE.success);
            Navigator.pushNamed(context, Routes.dashboard);
            context.read<DashBoardViewModel>().getPaymentCredentials(context);
          }
        } on SignInWithAppleException catch (e) {
          debugPrint(e.toString());
        }
      } else {}
    }
  }
}
