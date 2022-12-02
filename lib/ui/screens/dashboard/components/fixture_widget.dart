import 'package:flutter_svg/svg.dart';
import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/score_chip.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/dot_widget.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/live_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/shimmer_widget.dart';

class FixtureWidget extends StatefulWidget {
  final String leagueName;
  final String teamOneFlag;
  final String teamOneName;
  final String? teamOneScore;
  final String teamTwoFlag;
  final String teamTwoName;
  final String? teamTwoScore;
  final String? scheduledTime;
  final DateTime scheduledDate;
  final String? liveTime;
  final String? matchStatus;
  final bool isLive;
  final bool isOver;
  final bool withText;
  final Function(String) onTap;
   const FixtureWidget({
    Key? key,
    required this.leagueName,
    required this.teamOneFlag,
    required this.teamOneName,
    this.teamOneScore = "0",
    required this.teamTwoFlag,
    required this.teamTwoName,
    this.teamTwoScore = "0",
    this.scheduledTime,
    this.liveTime,
    this.isLive = false,
    this.withText = true,
    required this.onTap, this.matchStatus,
    required this.scheduledDate, 
    required this.isOver,
  }) : super(key: key);

  @override
  State<FixtureWidget> createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> {
  String? translatedLeagueName;
  String? translatedStatus;
  String? teamOneName;
  String? teamTwoName;
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isToday = DateUtility.isToday(widget.scheduledDate);
    return !isLoading ? GestureDetector(
      onTap: () => widget.onTap(translatedLeagueName!),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            gradient: AppColors.blackishGradient,
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.width * 50,
                    child: TextWidget(
                      text: translatedLeagueName!, 
                      textSize: 10, 
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,
                    )),
                  widget.isLive
                      ? LiveWidget(isLive: widget.isLive,)
                      : widget.withText
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.icCalender,
                              alignment: Alignment.topCenter,),
                            UIHelper.horizontalSpace(8.0),
                            TextWidget(
                              text: isToday ? "${loc.today}, " + widget.scheduledTime! : DateUtility.getUiFormat(widget.scheduledDate),
                              textSize: 10,
                              fontWeight: FontWeight.w400,
                            )
                          ],
                        )
                      : DotWidget(
                          isLive: !widget.isLive,
                    )
                ],
              ),
            ),
            Divider(
              color: AppColors.colorWhite.withOpacity(0.07),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  UIHelper.verticalSpace(15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextWidget(
                              text: teamOneName!,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              textSize: Dimens.textSmall,
                            )),
                            UIHelper.horizontalSpace(5),
                            ImageWidget(
                                imageUrl: widget.teamOneFlag,
                                placeholder: Assets.icTeamAvatar,
                                shouldClip: true,
                            ),
                          ],
                        ),
                      ),
                      widget.isLive || widget.isOver
                          ? Column(
                              children: [
                                UIHelper.verticalSpace(20),
                                ScoreChip(
                                  firstScore: widget.teamOneScore!,
                                  secondScore: widget.teamTwoScore!,
                                  hasGradient: false,
                                ),
                                TextWidget(
                                  text: translatedStatus!,
                                  color: AppColors.colorGrey,
                                  textSize: Dimens.textXS,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal : 5.0),
                            child: TextWidget(
                              text: loc.vs,
                              textSize: Dimens.textLarge,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageWidget(
                              imageUrl: widget.teamTwoFlag,
                              placeholder: Assets.icTeamAvatar,
                              shouldClip: true,
                            ),
                            UIHelper.horizontalSpace(5),
                            Expanded(
                              child: TextWidget(
                              text: teamTwoName!,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              textSize: Dimens.textSmall,
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  widget.isLive
                      ? UIHelper.verticalSpace(8.0)
                      : UIHelper.verticalSpace(20.0)
                ],
              ),
            ),
          ],
        ),
      ),
    )
    : const ShimmerWidget(height: 130,);
  }

  Future<void> translateData() async {
      String originalCommaText = widget.leagueName + ',' + widget.teamOneName + ',' + widget.teamTwoName + "," + widget.matchStatus!;
      String translatedCommaText = await TranslationUtility.translate(originalCommaText);
      List<String> listOfValues = [];
      if(translatedCommaText.contains("،")) {
         listOfValues = translatedCommaText.split("،");
      } else {
        listOfValues = translatedCommaText.split(",");
      }
        translatedLeagueName = listOfValues[0];
        teamOneName = listOfValues[1];
        teamTwoName = listOfValues[2];
        translatedStatus = widget.matchStatus!.isNotEmpty ? listOfValues[3] : widget.matchStatus;
        isLoading = false;
      setState(() {});
  }
}


