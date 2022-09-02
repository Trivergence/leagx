import 'package:leagx/ui/screens/user/components/user_role_button.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';

class UserRolesWidget extends StatefulWidget {
  final VoidCallback onUserTap;
  final VoidCallback onExpertTap;
  final VoidCallback onAdminTap;
  const UserRolesWidget({
    Key? key,
    required this.onUserTap,
    required this.onExpertTap,
    required this.onAdminTap,
  }) : super(key: key);

  @override
  State<UserRolesWidget> createState() => _UserRolesWidgetState();
}

class _UserRolesWidgetState extends State<UserRolesWidget> {
  bool isUserTapped = false;
  bool isExpertTapped = false;
  bool isAdminTapped = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserRoleButton(
          title: loc.userBtnUser,
          isTapped: isUserTapped,
          onTap: () {
            setState(() {
              isUserTapped = true;
              isExpertTapped = false;
              isAdminTapped = false;
            });
            widget.onUserTap();
          },
        ),
        UserRoleButton(
          title: loc.userBtnExpert,
          isTapped: isExpertTapped,
          onTap: () {
            setState(() {
              isUserTapped = false;
              isExpertTapped = true;
              isAdminTapped = false;
            });
            widget.onExpertTap();
          },
        ),
        UserRoleButton(
          title: loc.userBtnAdmin,
          isTapped: isAdminTapped,
          onTap: () {
            setState(() {
              isUserTapped = false;
              isExpertTapped = false;
              isAdminTapped = true;
            });
            widget.onAdminTap();
          },
        ),
      ],
    );
  }
}
