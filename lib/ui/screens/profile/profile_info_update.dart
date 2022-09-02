import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class ProfileInfoUpdateScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  ProfileInfoUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBarWidget(
        title: loc.profileProfileInfoUpdateTxtEditProfile,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            UIHelper.verticalSpace(40.0),
            Stack(
              children: [
                Container(
                  width: 96.0,
                  height: 96.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.imgAvatar,
                        ),
                        fit: BoxFit.fill),
                    shape: BoxShape.circle,
                  ),
                ),
                const Positioned(
                  bottom: 9.0,
                  right: 9.0,
                  child: GradientWidget(
                    child: Icon(Icons.camera_alt),
                    gradient: AppColors.pinkishGradient,
                  ),
                )
              ],
            ),
            UIHelper.verticalSpace(50.0),
            TextFieldWidget(
              textController: _nameController,
              hint: 'John Smith',
              prefix: const IconWidget(iconData: Icons.account_circle_outlined),
            ),
            UIHelper.verticalSpace(15.0),
            TextFieldWidget(
              textController: _emailController,
              hint: 'abc@xyz.com',
              prefix: const IconWidget(iconData: Icons.drafts_outlined),
            ),
            UIHelper.verticalSpace(15.0),
            TextFieldWidget(
              textController: _phoneController,
              hint: '1234567890',
              enabled: false,
              prefix: const IconWidget(iconData: Icons.smartphone),
            ),
            UIHelper.verticalSpace(15.0),
            TextFieldWidget(
              textController: _genderController,
              hint: 'Male',
              prefix: const IconWidget(iconData: Icons.perm_contact_cal),
              suffix: const IconWidget(
                iconData: Icons.arrow_drop_down,
              ),
            ),
            UIHelper.verticalSpace(90.0),
            MainButton(
              text: loc.profileProfileInfoUpdateBtnSave,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
