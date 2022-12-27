import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/ui/screens/user/components/user_roles_widget.dart';
import 'package:leagx/ui/screens/user/components/user_setting_button.dart';
import 'package:leagx/ui/screens/user/components/user_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: loc.userTxtUsers),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFieldWidget(
              textController: _searchController,
              hint: loc.userTxtSearch,
              suffix: const IconWidget(
                iconData: Icons.search,
              ),
            ),
            UIHelper.verticalSpace(15.0),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return UserTile(
                    imageUrl: Strings().placeHolderUrl,
                    title: "davin smith",
                    role: 'admin',
                    onIconPressed: () {
                      _showSettingSheet(
                        context: context,
                        child: Column(
                          children: [
                            UserSettingButton(
                              title: loc.userBtnChangeRole,
                              onTap: () {
                                Navigator.pop(context);
                                _showSettingSheet(
                                  context: context,
                                  child: Column(
                                    children: [
                                      UserRolesWidget(
                                        onUserTap: () {},
                                        onExpertTap: () {},
                                        onAdminTap: () {},
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            UIHelper.verticalSpace(15.0),
                            UserSettingButton(
                              title: loc.userBtnBlockUser,
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            UIHelper.verticalSpaceXL,
            MainButton(
              text: loc.userBtnInviteAUser,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  _showSettingSheet({required BuildContext context, required Widget child}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.colorBackground,
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(24.0), right: Radius.circular(24.0))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UIHelper.verticalSpace(23.0),
              TextWidget(
                text: loc.userTxtUserRoleSetting,
                textSize: 18.0,
                fontWeight: FontWeight.w600,
                color: AppColors.colorPink,
              ),
              UIHelper.verticalSpace(36.0),
              child,
              UIHelper.verticalSpaceXL,
            ],
          ),
        );
      },
    );
  }
}
