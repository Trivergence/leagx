import 'package:leagx/constants/assets.dart';
import 'package:leagx/models/choose_plan_args.dart';
import 'package:leagx/models/subscription_plan.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/choose_plan_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../widgets/bar/app_bar_widget.dart';
import 'components/plan_listing.dart';

class ChoosePlanScreen extends StatelessWidget {
  final ChoosePlanArgs leagueData;
  const ChoosePlanScreen({Key? key, required this.leagueData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: loc.choosePlanTxtChooseAPlan),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                child: ImageWidget(imageUrl: leagueData.leagueImg,),
                radius: 35,
              ),
              UIHelper.verticalSpace(8),
              TextWidget(text: leagueData.leagueTitle),
              UIHelper.verticalSpace(70),
              PlanListing(
                isAdmin: true,
                onItemPressed: (planId) {
                  context.read<ChoosePlanViewModel>().subscribeLeague(
                   context: context,
                   planId: planId,
                   leagueId: leagueData.leagueId,
                   leagueImg: leagueData.leagueImg,
                   leagueTitle: leagueData.leagueTitle
                   );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
