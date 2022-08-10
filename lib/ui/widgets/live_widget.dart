import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/dot_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LiveWidget extends StatelessWidget {
  const LiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const DotWidget(),
        UIHelper.horizontalSpace(3.0),
        const TextWidget(
          text: 'LIVE',
          textSize: Dimens.textSmall,
        ),
      ],
    );
  }
}
