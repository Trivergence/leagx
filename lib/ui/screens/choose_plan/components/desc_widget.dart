import 'package:leagx/constants/dimens.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/text_widget.dart';

class DescWidget extends StatelessWidget {
  final String text;
  final Gradient gradient;
  const DescWidget({
    Key? key,
    required this.text,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.done,
          size: 14,
          color: AppColors.colorPink,
        ),
        UIHelper.horizontalSpace(8),
        Expanded(
          child: TextWidget(
            text: text,
            textSize: Dimens.textSmall,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
