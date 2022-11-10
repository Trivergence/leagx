import 'package:leagx/constants/dimens.dart';
import 'package:flutter/material.dart';

import '../../../util/ui/ui_helper.dart';
import '../../../widgets/gradient/gradient_widget.dart';
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
        GradientWidget(
            gradient: gradient,
            child: const Icon(
              Icons.done,
              size: 14,
            )),
        UIHelper.horizontalSpace(8),
        Expanded(
          child: TextWidget(
            text: text,
            textSize: Dimens.textSmall,
          ),
        )
      ],
    );
  }
}
