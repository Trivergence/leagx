import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/models/prediction.dart';
import 'package:leagx/ui/screens/prediciton_s/components/prediction_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/placeholder_tile.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';

class PredicitonsScreen extends StatelessWidget {
  PredicitonsScreen({Key? key}) : super(key: key);

  late List<Prediction> listOfPrediction;

  @override
  Widget build(BuildContext context) {
    FixtureDetailViewModel fixtureModel = context.watch<FixtureDetailViewModel>();
    listOfPrediction = fixtureModel.getPredictions;
    return RefreshIndicator(
      backgroundColor: AppColors.textFieldColor,
      onRefresh: () async => await fixtureModel.getUserPredictions(),
      child: Scaffold(
        backgroundColor: AppColors.colorBackground,
        appBar: AppBarWidget(
          title: loc.predictionSTxtPredictions,
        ),
        body: listOfPrediction.isNotEmpty ? ListView.builder(
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
              predictionRate: prediction.accuratePercentage.toString(),
              isPending: isPending(prediction.status),
            );
          },
        )
        : Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PlaceHolderTile(height: 60, msgText: loc.predictionSTxtEmptyList),
        )),
      ),
    );
  }

  isPending(String? status) {
    if( status == "Finished" || status == "After ET" || status == "After Pen.") {
      return false;
    } else {
      return true;
    }
  }
}
