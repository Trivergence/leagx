import 'package:leagx/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/size/size_config.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/icon_container.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';
import '../components/prediction_bottom_sheet.dart';
import '../components/score_chip.dart';
import '../components/team_vs_widget.dart';
import 'components/player_tile.dart';

class PlayersView extends StatelessWidget {
  PlayersView({
    Key? key,
  }) : super(key: key);

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 15),
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
                    const TeamVsWidget(
                      teamName: 'Barcelona',
                      groupPosition: 'Top 1 group A',
                      image: Assets.flagImage,
                    ),
                    Column(
                      children: const [
                        ScoreChip(),
                        UIHelper.verticalSpaceSmall,
                        TextWidget(
                          text: "00:38:25",
                          color: AppColors.colorGrey,
                          textSize: Dimens.textSmall,
                        )
                      ],
                    ),
                    const TeamVsWidget(
                      teamName: 'Man. United',
                      groupPosition: 'Top 2 Group B',
                      image: Assets.flagImage2,
                    ),
                  ],
                )),
            IconContainer(
              height: SizeConfig.height * 7,
              title: "Team Players",
            ),
            Column(
              children: const [
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
                PlayerTile(),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            SizedBox(
                width: SizeConfig.width * 90,
                child: MainButton(text: "Predict", onPressed: _showSheet))
          ],
        ),
      ),
    );
  }

  void _showSheet() {
    showModalBottomSheet(
        context: _context!,
        backgroundColor: AppColors.colorBackground,
        builder: (context) {
          return PredictionSheetWidget(
              onSubmit: (mycontext) =>
                  Navigator.pushNamed(context, Routes.chooseAnExpert));
        });
  }
}
