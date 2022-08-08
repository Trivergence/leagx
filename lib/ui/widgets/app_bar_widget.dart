import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/validation/validation_utils.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final bool isDrawer;


  AppBarWidget(
      {Key? key,
      required this.title,
      this.trailing,
      this.isDrawer = false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: isDrawer?
           IconButton(
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
      title: TextWidget(
        text: title,
      ),
      actions: [
        trailing ?? const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
