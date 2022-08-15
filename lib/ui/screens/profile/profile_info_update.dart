import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class ProfileInfoUpdate extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  ProfileInfoUpdate({Key? key}) : super(key: key);

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
                        image: NetworkImage("https://pravatar.cc/")),
                    shape: BoxShape.circle,
                  ),
                ),
                const Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: GradientWidget(
                    child: Icon(Icons.camera),
                  ),
                )
              ],
            ),
            UIHelper.verticalSpace(50.0),
            TextFieldWidget(
              textController: _nameController,
              hint: 'John Smith',
              prefix: IconWidget(iconData:Icons.account_circle_outlined),
              validator: () {},
            ),
          ],
        ),
      ),
    );
  }
}
