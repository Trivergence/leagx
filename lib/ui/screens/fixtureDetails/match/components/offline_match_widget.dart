import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/dimens.dart';
import '../../../../../models/dashboard/events.dart';
import '../../../../../view_models/fixture_view_model.dart';
import '../../../../util/size/size_config.dart';
import '../../../../util/ui/ui_helper.dart';
import '../../../../widgets/divider_widget.dart';
import '../../../../widgets/main_button.dart';
import '../../../../widgets/text_widget.dart';

class OfflineMatchWidget extends StatelessWidget {
  final Events matchDetails;
  OfflineMatchWidget({
    Key? key, required this.matchDetails,
  }) : super(key: key);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Column(
      children: [
        const DividerWidget(),
        Container(
          width: SizeConfig.width * 100,
          margin: const EdgeInsets.only(bottom: 40),
          height: SizeConfig.height * 30,
          color: AppColors.textFieldColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.icSoccer),
              UIHelper.verticalSpaceMedium,
              TextWidget(
                text: loc.fixtureDetailsMatchTxtMatchToStartYet,
                textSize: Dimens.textSM,
                color: AppColors.colorGrey,
              )
            ],
          ),
        ),
        SizedBox(
            width: SizeConfig.width * 90,
            child: MainButton(
              text: loc.fixtureDetailsMatchBtnPredict,
              onPressed: _showSheet,
            ))
      ],
    );
  }

  void _showSheet() {
    _context
        .read<FixtureDetailViewModel>()
        .showPredictionSheet(_context, matchDetails);
  }
}
