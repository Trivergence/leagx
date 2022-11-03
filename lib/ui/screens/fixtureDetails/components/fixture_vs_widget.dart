import 'dart:async' as my_async;

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

  int hour = 0;
  int minute = 0;
  int seconds = 0;
  String timeString = "--:--:--";
  my_async.Timer? timer;

    @override
  void initState() {
    super.initState();
    if (!Utility.isMatchOver(widget.matchDetails.matchStatus!) && Utility.isTimeValid(widget.matchDetails.matchStatus!)) {
        minute = Utility.isMatchOver(widget.matchDetails.matchStatus!)
            ? 0
            : int.parse(widget.matchDetails.matchStatus!);
          timer = my_async.Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              setState(() {
                seconds = seconds + 1;
                if (seconds % 60 == 0) {
                  seconds = 0;
                  minute = minute + 1;
                  if (minute % 60 == 0) {
                    minute = 0;
                    hour = hour + 1;
                  }
            }
          
            if (widget.matchDetails.matchLive == "1") {
              String hrs = "0" + hour.toString();
              String mts =
                  minute < 10 ? "0" + minute.toString() : minute.toString();
              String sds =
                  seconds < 10 ? "0" + seconds.toString() : seconds.toString();
              timeString = hrs + ":" + mts + ":" + sds;
            }
          });
        },
          );
      } else {
        timeString = widget.matchDetails.matchStatus!;
      }

    translateData();
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
                            text: timeString,
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
