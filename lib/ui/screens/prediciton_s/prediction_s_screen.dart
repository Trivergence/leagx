import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/screens/prediciton_s/components/prediction_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:flutter/material.dart';

class PredicitonsScreen extends StatelessWidget {
  const PredicitonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBarWidget(
        title: loc.predictionSTxtPredictions,
      ),
      body: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontalPadding,
            vertical: Dimens.verticalPadding),
        itemBuilder: (context, index) {
          return const PredictionWidget(
            teamOneFlag: Assets.ufcFlag,
            teamOneName: 'UFC',
            teamOneScore: 3,
            teamTwoFlag: Assets.arsFlag,
            teamTwoName: 'ARS',
            teamTwoScore: 5,
            predictionRate: '95.9%',
            // isPending: true,
          );
        },
      ),
    );
  }
}
