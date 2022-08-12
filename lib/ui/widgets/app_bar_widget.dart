import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/validation/validation_utils.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool isIcon;
  final Widget? trailing;
  final bool isDrawer;

  AppBarWidget({
    Key? key,
    this.title,
    this.trailing,
    this.isDrawer = false,
    this.isIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: isDrawer
          ? IconButton(
              icon: const Icon(
                Icons.notes,
                color: AppColors.colorWhite,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          : IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.colorWhite,
              ),
              onPressed: () => Navigator.pop(context),
            ),
      title: isIcon
          ? Image.asset(
              Assets.appLogo,
              width: 32.0,
              height: 32.0,
            )
          : title != null
              ? TextWidget(
                  text: title!,
                )
              : const SizedBox(),
      actions: [
        trailing ?? const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
