import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../util/ui/ui_helper.dart';
import 'text_widget.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    Key? key,
    required this.height,
    required this.title,
  }) : super(key: key);

  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: AppColors.textFieldColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.icPlayer),
          UIHelper.horizontalSpaceSmall,
          TextWidget(text: title)
        ],
      ),
    );
  }
}
