import 'dart:async' as my_async;

import 'package:flutter/material.dart';
import 'package:leagx/ui/util/size/size_config.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../../core/utility.dart';
import '../../../../models/dashboard/fixture.dart';
import '../../../util/locale/localization.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../util/utility/date_utility.dart';
import '../../../util/utility/translation_utility.dart';
import '../../../widgets/image_widget.dart';
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeConfig.width * 30,
                      child: ImageWidget(
                        imageUrl: widget.matchDetails.teamHomeBadge,
                        placeholder: Assets.icTeamAvatar,
                        boxFit: null,
                      ),
                    ),
                    widget.matchDetails.matchLive == "1" ||
                                Utility.isMatchOver(widget.matchDetails.matchStatus!)
                            ? ScoreChip(
                              firstScore: widget.matchDetails.matchHometeamScore,
                              secondScore: widget.matchDetails.matchAwayteamScore,
                            )
                            : TextWidget(
                              text: loc.vs,
                              textSize: Dimens.textLarge,
                              fontWeight: FontWeight.bold,
                            ),
                     SizedBox(
                       width: SizeConfig.width * 30,
                       child: ImageWidget(
                        imageUrl: widget.matchDetails.teamAwayBadge,
                        placeholder: Assets.icTeamAvatar,
                        boxFit: null,
                    ),
                     ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: SizeConfig.width * 30,
                      child: TextWidget(
                        text: widget.matchDetails.matchHometeamName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.matchDetails.matchLive == "1" ||
                            Utility.isMatchOver(widget.matchDetails.matchStatus!)
                        ? TextWidget(
                          text: !Utility.isMatchOver(widget.matchDetails.matchStatus!) && Utility.isTimeValid(widget.matchDetails.matchStatus!)
                          ? timeString : matchStatus!,
                          color: AppColors.colorGrey,
                          textSize: Dimens.textSmall,
                        )
                        : TextWidget(
                          text: DateUtility.getUiFormat(
                              widget.matchDetails.matchDate),
                          color: AppColors.colorWhite,
                          textSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                    SizedBox(
                      width: SizeConfig.width * 30,
                      child: TextWidget(
                        text: widget.matchDetails.matchAwayteamName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeConfig.width * 30,
                      child: const TextWidget(
                        text: "Top 1 group A",
                        textSize: Dimens.textXS,
                        color: AppColors.colorWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    widget.matchDetails.matchLive == "1" ||
                            Utility.isMatchOver(
                                widget.matchDetails.matchStatus!)
                        ? TextWidget(
                            text: !Utility.isMatchOver(widget.matchDetails.matchStatus!) && Utility.isTimeValid(widget.matchDetails.matchStatus!)
                            ? timeString : matchStatus!,
                            color: AppColors.colorGrey,
                            textSize: Dimens.textSmall,
                          )
                        : TextWidget(
                            text: widget.matchDetails.matchTime,
                            color: AppColors.colorWhite,
                            textSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                    SizedBox(
                      width: SizeConfig.width * 30,
                      child: const TextWidget(
                        text: "Top 2 Group B",
                        textSize: Dimens.textXS,
                        color: AppColors.colorWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     TeamVsWidget(
            //       teamName: homeTeamName!,
            //       groupPosition: 'Top 1 group A',
            //       image: widget.matchDetails.teamHomeBadge,
            //     ),
            //     widget.matchDetails.matchLive == "1" ||
            //             Utility.isMatchOver(widget.matchDetails.matchStatus!)
            //         ? Column(
            //             children: [
            //               ScoreChip(
            //                 firstScore: widget.matchDetails.matchHometeamScore,
            //                 secondScore: widget.matchDetails.matchAwayteamScore,
            //               ),
            //               UIHelper.verticalSpaceSmall,
            //               TextWidget(
            //                 text: !Utility.isMatchOver(widget.matchDetails.matchStatus!) && Utility.isTimeValid(widget.matchDetails.matchStatus!)
            //                 ? timeString : matchStatus!,
            //                 color: AppColors.colorGrey,
            //                 textSize: Dimens.textSmall,
            //               )
            //             ],
            //           )
            //         : Column(
            //             children: [
            //               TextWidget(
            //                 text: loc.vs,
            //                 textSize: Dimens.textLarge,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //               UIHelper.verticalSpaceSmall,
            //               TextWidget(
            //                 text: DateUtility.getUiFormat(
            //                     widget.matchDetails.matchDate),
            //                 color: AppColors.colorWhite,
            //                 textSize: 11,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //               UIHelper.verticalSpaceSmall,
            //               TextWidget(
            //                 text: widget.matchDetails.matchTime,
            //                 color: AppColors.colorWhite,
            //                 textSize: 11,
            //                 fontWeight: FontWeight.w400,
            //               )
            //             ],
            //           ),
            //     TeamVsWidget(
            //       teamName: awayTeamName!,
            //       groupPosition: 'Top 2 Group B',
            //       image: widget.matchDetails.teamAwayBadge,
            //     ),
            //   ],
            // ),
          )
        : const ShimmerWidget(height: 150, horizontalPadding: 0,);
  }

  Future<void> translateData() async {
    String originalCommaText = widget.matchDetails.matchAwayteamName + 
      "," + widget.matchDetails.matchHometeamName +
      "," + widget.matchDetails.matchStatus!;
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
    matchStatus = widget.matchDetails.matchStatus!.isNotEmpty ? listOfValues[2] : widget.matchDetails.matchStatus!;
    isLoading = false;
    setState(() {});
  }
}
