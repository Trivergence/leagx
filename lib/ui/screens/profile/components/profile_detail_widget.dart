import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/gradient/gradient_border_widget.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';

class ProfileDetailWidget extends StatelessWidget {
  final String value;
  final String title;
  final String buttonTitle;
  final VoidCallback onBtnPressed;
  const ProfileDetailWidget({
    Key? key,
    required this.value,
    required this.title,
    required this.buttonTitle,
    required this.onBtnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientBorderWidget(
          onPressed: () {},
          gradient: AppColors.pinkishGradient,
          text: value,
          height: 60.0,
          width: 60.0,
          isCircular: true,
          placeHolderImg: '',
        ),
        UIHelper.verticalSpaceSmall,
        TextWidget(
          text: title,
          textSize: Dimens.textSmall,
          color: AppColors.colorWhite.withOpacity(0.6),
        ),
        UIHelper.verticalSpace(16.0),
        MainButton(
          width: 110.0,
          height: 26.0,
          text: buttonTitle,
          fontSize: 14.0,
          onPressed: onBtnPressed,
        ),
      ],
    );
  }
}
