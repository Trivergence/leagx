import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../../core/utility.dart';
import '../../../../models/dashboard/fixture.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../util/utility/date_utility.dart';
import '../../../util/utility/translation_utility.dart';
import '../../../widgets/score_chip.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/text_widget.dart';
import 'team_vs_widget.dart';

class FixtureVsWidget extends StatefulWidget {
  const FixtureVsWidget({
    Key? key,
    required this.matchDetails,
  }) : super(key: key);

  final Fixture matchDetails;

  @override
  State<FixtureVsWidget> createState() => _FixtureVsWidgetState();
}

class _FixtureVsWidgetState extends State<FixtureVsWidget> {
  String? awayTeamName;
  String? homeTeamName;
  String? matchStatus;
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.homeBackground),
                fit: BoxFit.fill,
              )),
            margin: const EdgeInsets.only(bottom: 10, top: 5),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TeamVsWidget(
                  teamName: homeTeamName!,
                  groupPosition: 'Top 1 group A',
                  image: widget.matchDetails.teamHomeBadge,
                ),
                widget.matchDetails.matchLive == "1" ||
                        Utility.isMatchOver(widget.matchDetails.matchStatus!)
                    ? Column(
                        children: [
                          ScoreChip(
                            firstScore: widget.matchDetails.matchHometeamScore,
                            secondScore: widget.matchDetails.matchAwayteamScore,
                          ),
                          UIHelper.verticalSpaceSmall,
                          TextWidget(
                            text: matchStatus!,
                            color: AppColors.colorGrey,
                            textSize: Dimens.textSmall,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Image.asset(Assets.vs),
                          UIHelper.verticalSpaceSmall,
                          TextWidget(
                            text: DateUtility.getUiFormat(
                                widget.matchDetails.matchDate),
                            color: AppColors.colorGrey,
                            textSize: Dimens.textSmall,
                          ),
                          UIHelper.verticalSpaceSmall,
                          TextWidget(
                            text: widget.matchDetails.matchTime,
                            color: AppColors.colorGrey,
                            textSize: Dimens.textSmall,
                          )
                        ],
                      ),
                TeamVsWidget(
                  teamName: awayTeamName!,
                  groupPosition: 'Top 2 Group B',
                  image: widget.matchDetails.teamAwayBadge,
                ),
              ],
            ))
        : const ShimmerWidget(height: 150, horizontalPadding: 0,);
  }

  Future<void> translateData() async {
    awayTeamName = await TranslationUtility.translate(
        widget.matchDetails.matchAwayteamName);
    homeTeamName = await TranslationUtility.translate(
        widget.matchDetails.matchHometeamName);
    matchStatus = await TranslationUtility.translate(
        widget.matchDetails.matchStatus!);
    isLoading = false;
    setState(() {});
  }
}
