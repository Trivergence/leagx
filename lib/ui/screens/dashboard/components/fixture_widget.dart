import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/utility/string_utility.dart';
import 'package:leagx/ui/widgets/score_chip.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/dot_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/live_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FixtureWidget extends StatelessWidget {
  final String leagueName;
  final String teamOneFlag;
  final String teamOneName;
  final String? teamOneScore;
  final String teamTwoFlag;
  final String teamTwoName;
  final String? teamTwoScore;
  final String? scheduledTime;
  final String? liveTime;
  final String? matchStatus;
  final bool isLive;
  final bool withText;
  final VoidCallback? onTap;
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
    this.onTap, this.matchStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                    child: TextWidget(text: leagueName, textSize: Dimens.textSmall, overflow: TextOverflow.ellipsis,)),
                  isLive
                      ?  LiveWidget(isLive: isLive,)
                      : withText
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const GradientWidget(
                                    child: Icon(Icons.access_time_outlined)),
                                UIHelper.horizontalSpace(4.0),
                                TextWidget(
                                    text: "Today, " + scheduledTime!,
                                    textSize: Dimens.textSmall),
                              ],
                            )
                          : DotWidget(
                              isLive: !isLive,
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
                      Row(
                        children: [
                          ImageWidget(
                            imageUrl: teamOneFlag,
                          ),
                          UIHelper.horizontalSpaceSmall,
                          TextWidget(text: StringUtility.getShortName(teamOneName)),
                        ],
                      ),
                      isLive
                          ? Column(
                              children: [
                                ScoreChip(
                                  firstScore: teamOneScore!,
                                  secondScore: teamTwoScore!,
                                ),
                                UIHelper.verticalSpaceSmall,
                                TextWidget(
                                  text: matchStatus!,
                                  color: AppColors.colorGrey,
                                  textSize: Dimens.textSmall,
                                )
                              ],
                            )
                          : Image.asset(Assets.vs),
                      Row(
                        children: [
                          ImageWidget(
                            imageUrl: teamTwoFlag,
                          ),
                          UIHelper.horizontalSpaceSmall,
                          TextWidget(text: StringUtility.getShortName(teamTwoName)),
                        ],
                      ),
                    ],
                  ),
                  // isLive
                  //     ? TextWidget(
                  //         text: liveTime!,
                  //         color: AppColors.colorWhite.withOpacity(0.6))
                  //     : const SizedBox(),
                  isLive
                      ? UIHelper.verticalSpace(8.0)
                      : UIHelper.verticalSpace(20.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
