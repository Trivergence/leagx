import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/icon_container.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/score_chip.dart';
import 'components/live_match_widget.dart';

class MatchView extends StatelessWidget {
  const MatchView({
    Key? key,
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
                    Column(
                      children: [
                        Image.asset(Assets.flagImage),
                        const TextWidget(text: "Barcelona"),
                        UIHelper.verticalSpaceSmall,
                        const TextWidget(
                          text: "Top 1 Group A",
                          textSize: Dimens.textXS,
                          color: AppColors.colorGrey,
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        ScoreChip(firstScore: 1,secondScore: 4,),
                        UIHelper.verticalSpaceSmall,
                        TextWidget(
                          text: "00:38:25",
                          color: AppColors.colorGrey,
                          textSize: Dimens.textSmall,
                        )
                      ],
                    ),
                    Column(children: [
                      Image.asset(Assets.flagImage2),
                      const TextWidget(text: "Man. United"),
                      UIHelper.verticalSpaceSmall,
                      const TextWidget(
                        text: "Top 2 Group B",
                        textSize: Dimens.textXS,
                        color: AppColors.colorGrey,
                      ),
                    ])
                  ],
                )),
            IconContainer(
              height: SizeConfig.height * 7,
              title: loc.faqsTxtFrequentlyAskedQuestions,
            ),
            LiveMatchWidget()
            //OfflineMatchWidget()
          ],
        ),
      ),
    );
  }
}
