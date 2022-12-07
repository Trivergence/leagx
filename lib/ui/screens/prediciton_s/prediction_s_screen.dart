import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/models/prediction.dart';
import 'package:leagx/ui/screens/prediciton_s/components/prediction_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/placeholder_tile.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/network/internet_info.dart';
import '../../../core/utility.dart';

// ignore: must_be_immutable
class PredicitonsScreen extends StatelessWidget {
  PredicitonsScreen({Key? key}) : super(key: key);

  late List<Prediction> listOfPrediction;

  @override
  Widget build(BuildContext context) {
    FixtureDetailViewModel fixtureModel = context.watch<FixtureDetailViewModel>();
    listOfPrediction = fixtureModel.getPredictions;
    return RefreshIndicator(
      backgroundColor: AppColors.textFieldColor,
      onRefresh: () async {
        bool isConnected = await InternetInfo.isConnected();
        if (isConnected == true) {
          await fixtureModel.getUserPredictions();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.colorBackground,
        appBar: AppBarWidget(
          title: loc.predictionSTxtPredictions,
        ),
        body: listOfPrediction.isNotEmpty ? SizedBox(
          height: double.infinity,
          child: ListView.builder(
            itemCount: listOfPrediction.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontalPadding,
                vertical: Dimens.verticalPadding),
            itemBuilder: (context, index) {
              Prediction prediction = listOfPrediction[index];
              Match match = prediction.match;
              return PredictionWidget(
                teamOneFlag: match.firstTeamLogo!,
                teamOneName: match.firstTeamName!,
                teamOneScore: prediction.firstTeamScore,
                teamTwoFlag: match.secondTeamLogo!,
                teamTwoName: match.secondTeamName!,
                teamTwoScore: prediction.secondTeamScore,
                predictionRate: prediction.accuratePercentage != null 
                  ? prediction.accuratePercentage.toString()
                  : "0.0",
                isPending: Utility.isPredictionPending(prediction.status),
              );
            },
          ),
        )
        : Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PlaceHolderTile(height: 60, msgText: loc.predictionSTxtEmptyList),
        )),
      ),
    );
  }
}
