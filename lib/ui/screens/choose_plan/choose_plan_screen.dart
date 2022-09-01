import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/ui/util/locale/localization.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';
import 'components/plan_listing.dart';

class ChoosePlanScreen extends StatelessWidget {
  final bool isAdmin;
  const ChoosePlanScreen({Key? key, this.isAdmin = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: loc.choosePlanTxtChooseAPlan),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(Assets.leagueImage1),
                radius: 35,
              ),
              UIHelper.verticalSpace(8),
              const TextWidget(text: "FIFA"),
              UIHelper.verticalSpace(70),
              PlanListing(
                isAdmin: isAdmin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
