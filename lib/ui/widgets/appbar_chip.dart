import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

import '../../constants/colors.dart';

class AppBarChip extends StatelessWidget {
  final String totalValue;
  final String leadingIcon;

  const AppBarChip({
    Key? key,
    required this.totalValue,
    required this.leadingIcon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: Chip(
          side: const BorderSide(),
          labelPadding: const EdgeInsets.only(left: 4, right: 4),
          backgroundColor: AppColors.textFieldColor,
          avatar: SvgPicture.asset(leadingIcon),
          label: TextWidget(
            text: totalValue,
            textSize: 10,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}
