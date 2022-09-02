import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PredictionWidget extends StatelessWidget {
  final String teamOneFlag;
  final String teamOneName;
  final int? teamOneScore;
  final String teamTwoFlag;
  final String teamTwoName;
  final int? teamTwoScore;
  final bool isPending;
  final String? predictionRate;
  const PredictionWidget({
    Key? key,
    required this.teamOneFlag,
    required this.teamOneName,
    this.teamOneScore,
    required this.teamTwoFlag,
    required this.teamTwoName,
    this.teamTwoScore,
    this.isPending = false,
    this.predictionRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          gradient: AppColors.blackishGradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            gradient: LinearGradient(colors: [
                              Color(0xFF2A3041),
                              Color(0xFF2B344D),
                              Color(0xFF2A3041),
                            ])),
                        child: Row(
                          children: [
                            TextWidget(text: teamOneScore.toString()),
                            UIHelper.horizontalSpace(10.0),
                            const TextWidget(text: '-'),
                            UIHelper.horizontalSpace(10.0),
                            TextWidget(text: teamTwoScore.toString()),
                          ],
                        ),
                      ),
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
                  isPending
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const IconWidget(
                              iconData: Icons.campaign_outlined,
                              color: AppColors.colorYellow,
                              size: 18,
                            ),
                            UIHelper.horizontalSpace(6.0),
                             TextWidget(
                              text:loc.predictionSTxtPending ,
                              color: AppColors.colorYellow,
                              textSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                      : predictionRate != null
                          ? TextWidget(
                              text: predictionRate!,
                              color: AppColors.colorGreen)
                          : const SizedBox(),
                ],
              )),
        ],
      ),
    );
  }
}
