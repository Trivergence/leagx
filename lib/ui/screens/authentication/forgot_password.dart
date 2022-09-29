import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/models/auth/forgot_password.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui/validation_helper.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/auth_view_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: loc.authForgotPasswordTxtForgotPassword,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.horizontalSpaceMedium),
              child: TextWidget(
                text: loc.authForgotPasswordTxtEnterEmailDesc,
                textAlign: TextAlign.center,
              ),
            ),
            UIHelper.verticalSpaceLarge,
            Form(
              key: _formKey,
              child: TextFieldWidget(
                textController: _emailController,
                hint: loc.authForgotPasswordTxtemailOrPhone,
                prefix: const IconWidget(
                  iconData: Icons.drafts_outlined,
                ),
                validator: (value) => ValidationHelper.validateEmail(value),
                inputType: TextInputType.emailAddress,
              ),
            ),
            UIHelper.verticalSpaceLarge,
            MainButton(
              text: loc.authForgotPasswordBtnResetPassword,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Loader.showLoader();
                  ForgotPassword? forgotPasswordResponse =
                      await AuthViewModel.forgotPassword(
                    email: _emailController.text,
                  );
                  Loader.hideLoader();
                  if (ValidationUtils.isValid(forgotPasswordResponse)) {
                    ToastMessage.show(
                        forgotPasswordResponse!.success!, TOAST_TYPE.msg);
                    Navigator.pushReplacementNamed(context, Routes.signin);
                  }
                }
              },
            ),
            /*UIHelper.verticalSpaceMedium,
            HaveAccountButton(
              subText: 'Sign Up',
              onTap: () {
                Navigator.pushNamed(context, Routes.signup);
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
