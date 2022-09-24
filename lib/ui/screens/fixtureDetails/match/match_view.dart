import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/icon_container.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/score_chip.dart';
import '../components/team_vs_widget.dart';
import 'components/live_match_widget.dart';
import 'components/offline_match_widget.dart';

class MatchView extends StatelessWidget {
  final Fixture matchDetails;

  const MatchView({
    Key? key, required this.matchDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: AppColors.textFieldColor,
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TeamVsWidget(
                      teamName: matchDetails.matchHometeamName,
                      groupPosition: 'Top 1 group A',
                      image: matchDetails.teamHomeBadge,
                    ),
                    matchDetails.matchLive == "1" ? Column(
                      children: [
                        ScoreChip(firstScore: matchDetails.matchHometeamScore,
                          secondScore: matchDetails.matchAwayteamScore,),
                        UIHelper.verticalSpaceSmall,
                        TextWidget(
                          text: matchDetails.matchStatus!,
                          color: AppColors.colorGrey,
                          textSize: Dimens.textSmall,
                        )
                      ],
                    ) : Column(
                      children: [
                        Image.asset(Assets.vs),
                        UIHelper.verticalSpaceSmall,
                        TextWidget(
                          text: DateUtility.getUiFormat(matchDetails.matchDate),
                          color: AppColors.colorGrey,
                          textSize: Dimens.textSmall,
                        ),
                        UIHelper.verticalSpaceSmall,
                        TextWidget(
                          text: matchDetails.matchTime,
                          color: AppColors.colorGrey,
                          textSize: Dimens.textSmall,
                        )
                      ],
                    ),
                    TeamVsWidget(
                      teamName: matchDetails.matchAwayteamName,
                      groupPosition: 'Top 2 Group B',
                      image: matchDetails.teamAwayBadge,
                    ),
                  ],
                )),
            IconContainer(
              height: SizeConfig.height * 7,
              title: loc.faqsTxtFrequentlyAskedQuestions,
            ),
            matchDetails.matchLive == "1" ? LiveMatchWidget(matchDetails: matchDetails,) : OfflineMatchWidget(matchDetails: matchDetails)
          ],
        ),
      ),
    );
  }
}
