import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/screens/admin/components/legend_tab.dart';

import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          LegendTab(text: 'Predictions', gradient: AppColors.blueishGradient),
          LegendTab(text: 'Purchases', gradient: AppColors.pinkishGradient),
          LegendTab(text: 'Withdraw', gradient: AppColors.orangishGradient),
        ],
      ),
    );
  }
}
