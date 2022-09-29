import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/utility/string_utility.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class MatchPredictionTile extends StatelessWidget {
  final String? homeTeamName;
  final String? awayTeamName;
  final int homeScore;
  final int awayScore;
  const MatchPredictionTile({
    Key? key, required this.homeTeamName, required this.awayTeamName, required this.homeScore, required this.awayScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String awayShortName = StringUtility.getShortName(awayTeamName!);
    String homeShortName = StringUtility.getShortName((homeTeamName!));
    return Container(
      color: AppColors.textFieldColor,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: loc.fixtureDetailsMatchTxtYourPredictions,
          ),
          Column(
            children: [
              TextWidget(
                text: "$homeShortName - $homeScore",
                color: AppColors.colorCyan,
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                  text: "$awayShortName - $awayScore",
                  color: AppColors.colorYellow,
                  fontWeight: FontWeight.w600),
            ],
          )
        ],
      ),
    );
  }
}
