import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LegendTab extends StatelessWidget {
  final String text;
  final Gradient gradient;
  const LegendTab({Key? key, required this.text, required this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 12.0,
        height: 6.0,
        decoration: BoxDecoration(gradient: gradient),
      ),
      UIHelper.horizontalSpace(5.0),
      TextWidget(
        text: text,
        textSize: 12.0,
      ),
    ]);
  }
}
