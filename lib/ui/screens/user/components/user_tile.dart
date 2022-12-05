import 'package:leagx/ui/util/utility/image_utitlity.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

// ignore: must_be_immutable
class UserTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? role;
  final VoidCallback onIconPressed;
  String _userRole = ' ';

  UserTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.role,
    required this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _userRole = role != null ? "($role)" : "";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        gradient: AppColors.blackishGradient,
      ),
      child: Row(
        children: [
          GradientBorderWidget(
            width: 44.0,
            height: 44.0,
            isCircular: true,
            imageUrl: imageUrl,
            placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
            onPressed: () {},
            gradient: AppColors.orangishGradient,
            isBorderSolid: true,
          ),
          UIHelper.horizontalSpace(15.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "$title $_userRole",
                ),
                IconButton(
                  onPressed: onIconPressed,
                  icon: const IconWidget(
                    iconData: Icons.more_vert,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
