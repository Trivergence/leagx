import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? backColor;
  final VoidCallback? onBackPressed;

  AppBarWidget({
    Key? key,
    required this.title,
    this.actions,
    this.backgroundColor = AppColors.colorPrimary,
    this.backColor = Colors.white,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: backColor,
        ),
        onPressed: () {
          if (onBackPressed == null) {
            Navigator.of(context).pop();
          } else {
            onBackPressed!();
          }
        },
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
