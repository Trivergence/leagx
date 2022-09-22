import 'package:leagx/constants/assets.dart';
import 'package:leagx/models/subscription_plan.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/bar/app_bar_widget.dart';
import 'components/plan_listing.dart';

class ChoosePlanScreen extends StatelessWidget {
  final Map<String,String>? leagueData;
  const ChoosePlanScreen({Key? key, this.leagueData}) : super(key: key);

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
                child: ImageWidget(imageUrl: leagueData!["imgUrl"],),
                radius: 35,
              ),
              UIHelper.verticalSpace(8),
              TextWidget(text: leagueData!["leagueTitle"]!),
              UIHelper.verticalSpace(70),
              const PlanListing(
                isAdmin: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
