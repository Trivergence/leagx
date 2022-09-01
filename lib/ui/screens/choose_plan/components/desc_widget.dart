import 'package:leagx/constants/dimens.dart';
import 'package:flutter/material.dart';

import '../../../util/ui/ui_helper.dart';
import '../../../util/ui_model/subscription_plan.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/text_widget.dart';

class DescWidget extends StatelessWidget {
  final String text;
  final int index;
  const DescWidget({
    Key? key,
    required this.text,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GradientWidget(
            gradient: listOfPlans[index].gradient!,
            child: const Icon(
              Icons.done,
              size: 14,
            )),
        UIHelper.horizontalSpace(8),
        TextWidget(
          text: text,
          textSize: Dimens.textSmall,
        )
      ],
    );
  }
}
