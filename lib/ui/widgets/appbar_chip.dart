import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

import '../../constants/colors.dart';

class AppBarChip extends StatelessWidget {
  final String totalValue;
  final String leading;

  const AppBarChip({
    Key? key,
    required this.totalValue,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: Chip(
          side: const BorderSide(),
          labelPadding: const EdgeInsets.only(right: 4),
          backgroundColor: AppColors.textFieldColor,
          avatar: TextWidget(
            text: leading,
            textSize: 15,
            fontWeight: FontWeight.bold,
          ),
          label: TextWidget(
            text: "x $totalValue",
            textSize: 13,
          )),
    );
  }
}
