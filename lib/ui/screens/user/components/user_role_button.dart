import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class UserRoleButton extends StatelessWidget {
  final String title;
  final bool isTapped;
  final VoidCallback onTap;
  const UserRoleButton({
    Key? key,
    required this.title,
    required this.isTapped,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 15.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: AppColors.colorWhite.withOpacity(0.12), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: title,
              textSize: 16.0,
            ),
            isTapped
                ? const IconWidget(
                    iconData: Icons.check,
                    color: AppColors.colorCyan,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
