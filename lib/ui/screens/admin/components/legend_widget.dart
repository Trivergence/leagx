import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/screens/admin/components/legend_tab.dart';

import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          LegendTab(text: loc.adminHomeTxtPredictions, gradient: AppColors.blueishGradient),
          LegendTab(text: loc.adminHomeTxtPurchases, gradient: AppColors.pinkishGradient),
          LegendTab(text: loc.adminHomeTxtWithdraw, gradient: AppColors.orangishGradient),
        ],
      ),
    );
  }
}
