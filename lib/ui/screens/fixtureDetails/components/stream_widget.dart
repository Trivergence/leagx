import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../util/size/size_config.dart';

class StreamWidget extends StatelessWidget {
  final Widget child;
  const StreamWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width * 100,
      margin: const EdgeInsets.only(bottom: 40),
      height: SizeConfig.height * 30,
      color: AppColors.textFieldColor,
      child: child,
    );
  }
}
