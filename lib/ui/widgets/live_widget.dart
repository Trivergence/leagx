import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/dot_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LiveWidget extends StatelessWidget {
  final bool isLive;
  const LiveWidget({Key? key, required this.isLive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DotWidget(
          isLive: isLive,
        ),
        UIHelper.horizontalSpace(3.0),
        TextWidget(
          text: loc.liveWidgetTxtLive,
          textSize: Dimens.textSmall,
        ),
      ],
    );
  }
}
