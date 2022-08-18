import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class ProfileInfoUpdateScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  ProfileInfoUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBarWidget(
        isIcon: true,
        isDrawer: true,
        trailing: IconButton(
          icon: const IconWidget(
            iconData: Icons.notifications_outlined,
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                      fit: BoxFit.fill
                    ),
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
              textController: _nameController,
              hint: 'abc@xyz.com',
              prefix: const IconWidget(iconData: Icons.drafts_outlined),
            ),
            UIHelper.verticalSpace(15.0),
            TextFieldWidget(
              textController: _nameController,
              hint: '1234567890',
              prefix: const IconWidget(iconData: Icons.smartphone),
            ),
            UIHelper.verticalSpace(15.0),
            TextFieldWidget(
              textController: _nameController,
              hint: 'Male',
              prefix: IconWidget(iconData: Icons.perm_contact_cal),
              suffix: IconWidget(
                iconData: Icons.arrow_drop_down,
              ),
            ),
            UIHelper.verticalSpace(90.0),
            MainButton(
              text: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
