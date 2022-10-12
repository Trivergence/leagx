import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';
import 'package:leagx/ui/util/utility/string_utility.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/score_chip.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/dot_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/live_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
  final VoidCallback? onTap;
   FixtureWidget({
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
    this.onTap, this.matchStatus,
    required this.scheduledDate, 
    required this.isOver,
  }) : super(key: key);

  @override
  State<FixtureWidget> createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> {
  String translatedLeagueName = "--";
  String translatedStatus = "--";
  String teamOneName = "--";
  String teamTwoName = "--";
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
      onTap: widget.onTap,
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
                      text: translatedLeagueName, 
                      textSize: Dimens.textSmall, 
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      )),
                  widget.isLive
                      ? LiveWidget(isLive: widget.isLive,)
                      : widget.withText
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const GradientWidget(
                                    child: Icon(Icons.access_time_outlined)),
                                UIHelper.horizontalSpace(4.0),
                                //TODO localization
                                TextWidget(
                                    text: isToday ? "${loc.today}, " + widget.scheduledTime! : DateUtility.getUiFormat(widget.scheduledDate),
                                    textSize: Dimens.textSmall),
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  UIHelper.verticalSpace(15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            ClipOval(
                              child: ImageWidget(
                                imageUrl: widget.teamOneFlag,
                                placeholder: Assets.icTeamAvatar
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            TextWidget(text: teamTwoName),
                          ],
                        ),
                      ),
                      widget.isLive || widget.isOver
                          ? Column(
                              children: [
                                ScoreChip(
                                  firstScore: widget.teamOneScore!,
                                  secondScore: widget.teamTwoScore!,
                                ),
                                UIHelper.verticalSpaceSmall,
                                TextWidget(
                                  text: translatedStatus,
                                  color: AppColors.colorGrey,
                                  textSize: Dimens.textSmall,
                                )
                              ],
                            )
                          : Image.asset(Assets.vs),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ImageWidget(
                              imageUrl: widget.teamTwoFlag,
                              placeholder: Assets.icTeamAvatar,
                            ),
                            UIHelper.horizontalSpaceSmall,
                            TextWidget(text: teamTwoName),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // isLive
                  //     ? TextWidget(
                  //         text: liveTime!,
                  //         color: AppColors.colorWhite.withOpacity(0.6))
                  //     : const SizedBox(),
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
      translatedLeagueName = await TranslationUtility.translate(widget.leagueName);
      translatedStatus =
        await TranslationUtility.translate(widget.matchStatus!);
        teamOneName = await TranslationUtility.translate(StringUtility.getShortName(widget.teamOneName));
        teamTwoName = await TranslationUtility.translate(StringUtility.getShortName(widget.teamTwoName));
        isLoading = false;
      setState(() {});
  }
}


