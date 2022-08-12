import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/dot_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/image_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/live_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FixtureWidget extends StatelessWidget {
  final String leagueName;
  final String teamOneFlag;
  final String teamOneName;
  final int? teamOneScore;
  final String teamTwoFlag;
  final String teamTwoName;
  final int? teamTwoScore;
  final String? scheduledTime;
  final String? liveTime;
  final bool isLive;
  final bool withText;
  final VoidCallback? onTap;
  const FixtureWidget({
    Key? key,
    required this.leagueName,
    required this.teamOneFlag,
    required this.teamOneName,
    this.teamOneScore,
    required this.teamTwoFlag,
    required this.teamTwoName,
    this.teamTwoScore,
    this.scheduledTime,
    this.liveTime,
    this.isLive = false,
    this.withText = true,
    this.onTap,
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
                children: [
                  TextWidget(text: leagueName, textSize: Dimens.textSmall),
                  isLive
                      ? const LiveWidget()
                      : withText
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const GradientWidget(
                                    child: Icon(Icons.access_time_outlined)),
                                UIHelper.horizontalSpace(4.0),
                                TextWidget(
                                    text: scheduledTime!,
                                    textSize: Dimens.textSmall),
                              ],
                            )
                          : const DotWidget(
                              color: AppColors.colorGrey,
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
                            imageAsset: teamOneFlag,
                            placeholder: Assets.ufcFlag,
                          ),
                          TextWidget(text: teamOneName),
                        ],
                      ),
                      isLive
                          ? Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      gradient: LinearGradient(colors: [
                                        Color(0xFF2A3041),
                                        Color(0xFF2B344D),
                                        Color(0xFF2A3041),
                                      ])),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: teamOneScore.toString(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      UIHelper.horizontalSpace(10.0),
                                      const TextWidget(text: '-'),
                                      UIHelper.horizontalSpace(10.0),
                                      TextWidget(
                                        text: teamTwoScore.toString(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Image.asset(Assets.vs),
                      Row(
                        children: [
                          ImageWidget(
                            imageAsset: teamTwoFlag,
                            placeholder: Assets.arsFlag,
                          ),
                          TextWidget(text: teamTwoName),
                        ],
                      ),
                    ],
                  ),
                  isLive
                      ? TextWidget(
                          text: liveTime!,
                          color: AppColors.colorWhite.withOpacity(0.6))
                      : const SizedBox(),
                      isLive? UIHelper.verticalSpace(8.0): UIHelper.verticalSpace(20.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
