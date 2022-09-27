import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool isIcon;
  final List<Widget>? trailing;
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
              ? SizedBox(
                width: SizeConfig.width * 50,
                child: Center(
                  child: TextWidget(
                      text: title!,
                      overflow: TextOverflow.fade,
                    ),
                ),
              )
              : const SizedBox.shrink(),
      actions: trailing ?? trailing,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
