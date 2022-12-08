import 'dart:ui';

import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/score_chip.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PredictionWidget extends StatefulWidget {
  final String teamOneFlag;
  final String teamOneName;
  final int? teamOneScore;
  final String teamTwoFlag;
  final String teamTwoName;
  final int? teamTwoScore;
  final bool isPending;
  final String? predictionRate;
  final bool isLocked;
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
    required this.isLocked,
  }) : super(key: key);

  @override
  State<PredictionWidget> createState() => _PredictionWidgetState();
}

class _PredictionWidgetState extends State<PredictionWidget> {
  String? teamOneName;
  String? teamTwoName;
  bool isLoading = true;

  @override
  void initState() {
    getTranslatedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading ? Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  fontWeight: FontWeight.bold,
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
                          Column(
                            children: [
                              UIHelper.verticalSpace(30),
                              ScoreChip(
                                hasGradient: false,
                                firstScore: widget.teamOneScore.toString(), 
                                secondScore: widget.teamTwoScore.toString()),
                              UIHelper.verticalSpaceSmall,
                              widget.isPending
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const IconWidget(
                                      iconData: Icons.campaign_outlined,
                                      color: AppColors.colorYellow,
                                      size: 18,
                                    ),
                                    UIHelper.horizontalSpace(6.0),
                                    TextWidget(
                                      text: loc.predictionSTxtPending,
                                      color: AppColors.colorYellow,
                                      textSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : widget.predictionRate != null
                                  ? TextWidget(
                                      text: widget.predictionRate! + "%",
                                      color: AppColors.colorGreen)
                                  : const SizedBox(),
                            ],
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
                                  fontWeight: FontWeight.bold,
                                )),
                              ],
                            )
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
        if (widget.isLocked)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        if (widget.isLocked) const Icon(Icons.lock),
      ],
    )
    : const ShimmerWidget(height: 120);
  }

  Future<void> getTranslatedData() async {
    String originalCommaText = widget.teamOneName + "," + widget.teamTwoName;
    String translatedCommaText =
        await TranslationUtility.translate(originalCommaText);
    List<String> listOfValues = [];
    if (translatedCommaText.contains("،")) {
      listOfValues = translatedCommaText.split("،");
    } else {
      listOfValues = translatedCommaText.split(",");
    }
    teamOneName = listOfValues[0];
    teamTwoName = listOfValues[1];
    isLoading = false;
    setState(() {
    });

  }
}
