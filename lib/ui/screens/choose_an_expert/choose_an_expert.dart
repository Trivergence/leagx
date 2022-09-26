import 'package:leagx/constants/strings.dart';
import 'package:leagx/ui/screens/choose_an_expert/components/choose_an_expert_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/leader.dart';

class ChooseAnExpertScreen extends StatelessWidget {
  ChooseAnExpertScreen({Key? key}) : super(key: key);

  List<Leader> expertList = [];

  @override
  Widget build(BuildContext context) {
    expertList = context.read<DashBoardViewModel>().getLeaders;
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.chooseAnExpertTxtChooseAnExpert,
      ),
      body: ListView.builder(
        itemCount: expertList.length > 10 ? 10 : expertList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Leader expert = expertList[index];
          return ChooseAnExpertTile(
            number: index + 1,
            imageUrl: expert.profileImg,
            title: expert.firstName! + expert.lastName!,
            numberOfPrediciton: expert.totalPredictions,
            successRate: expert.predictionSuccessRate.toString(),
            onTileTap: () => Navigator.of(context).pop(expert.id),
          );
        },
      ),
    );
  }
}
