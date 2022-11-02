import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/utility/string_utility.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class MatchPredictionTile extends StatefulWidget {
  final String? homeTeamName;
  final String? awayTeamName;
  final int homeScore;
  final int awayScore;
  const MatchPredictionTile({
    Key? key, required this.homeTeamName, required this.awayTeamName, required this.homeScore, required this.awayScore,
  }) : super(key: key);

  @override
  State<MatchPredictionTile> createState() => _MatchPredictionTileState();
}

class _MatchPredictionTileState extends State<MatchPredictionTile> {
  String? homeTeamName;
  String? awayTeamName;
  bool isLoading = true;
  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading ? Container(
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextWidget(
                text: "$homeTeamName - ${widget.homeScore}",
                color: AppColors.colorCyan,
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                  text: "$awayTeamName - ${widget.awayScore}",
                  color: AppColors.colorYellow,
                  fontWeight: FontWeight.w600),
            ],
          )
        ],
      ),
    )
    : const ShimmerWidget(height: 70);
  }

  Future<void> translateData() async {
    String originalCommaText = widget.awayTeamName! +
        ',' +
        widget.homeTeamName!;
    String translatedCommaText =
        await TranslationUtility.translate(originalCommaText);
    List<String> listOfValues = [];
    if (translatedCommaText.contains("،")) {
      listOfValues = translatedCommaText.split("،");
    } else {
      listOfValues = translatedCommaText.split(",");
    }
     awayTeamName = listOfValues[0];
     homeTeamName = listOfValues[1];
    isLoading = false;
    setState(() {});
  }
}
