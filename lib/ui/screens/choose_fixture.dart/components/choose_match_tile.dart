import 'package:flutter/material.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/locale/localization.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/text_widget.dart';

class ChooseFixtureTile extends StatefulWidget {
  const ChooseFixtureTile(
      {Key? key,
      required this.leagueId,
      required this.matchId, 
      required this.awayTeamName, 
      required this.homeTeamName, 
      required this.teamOneFlag, 
      required this.teamTwoFlag,
      })
      : super(key: key);
  final String leagueId;
  final String matchId;
  final String awayTeamName;
  final String homeTeamName;
  final String teamOneFlag;
  final String teamTwoFlag;

  @override
  State<ChooseFixtureTile> createState() => _ChooseFixtureTileState();
}

class _ChooseFixtureTileState extends State<ChooseFixtureTile> {
  String? homeName;
  String? awayName;
  String leagueTitle = "";
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading ? InkWell(
      onTap: () => Navigator.pop(context, {
        "matchId": widget.matchId,
        "leagueId": widget.leagueId,
        "vsTitle": "$homeName  -  $awayName",
      }),
      child: Container(
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
                                      text: homeName!,
                                      textAlign: TextAlign.center,
                                    )),
                                    UIHelper.horizontalSpace(5),
                                    ClipOval(
                                      child: ImageWidget(
                                          imageUrl: widget.teamOneFlag,
                                          placeholder: Assets.icTeamAvatar,
                                          shouldClip: true,),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
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
                                        text: awayName!,
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
    )
    : const ShimmerWidget(height: 100);
  }

  Future<void> translateData() async {
    String originalCommaText = widget.homeTeamName + ',' + widget.awayTeamName;
    String translatedCommaText =
        await TranslationUtility.translate(originalCommaText);
    List<String> listOfValues = [];
    if (translatedCommaText.contains("،")) {
      listOfValues = translatedCommaText.split("،");
    } else {
      listOfValues = translatedCommaText.split(",");
    }
    homeName = listOfValues[0];
    awayName = listOfValues[1];
    isLoading = false;
    setState(() {});
  }
}
