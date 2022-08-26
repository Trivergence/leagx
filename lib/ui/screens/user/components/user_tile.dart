import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';

class UserTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? role;
  final VoidCallback onIconPressed;
  String _userRole =' ' ;

   UserTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.role,
    required this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _userRole=role!=null? "($role)":"";
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
            onPressed: () {},
            gradient: AppColors.orangishGradient,
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
