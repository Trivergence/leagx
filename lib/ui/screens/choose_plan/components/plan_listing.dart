import 'package:flutter/material.dart';

import '../../../util/ui_model/subscription_plan.dart';
import 'plan_widget.dart';

class PlanListing extends StatefulWidget {
  const PlanListing({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanListing> createState() => _PlanListingState();
}

class _PlanListingState extends State<PlanListing> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: listOfPlans.length,
      itemBuilder: (context, index) {
        return PlanWidget(index: index, isSelected: index == selectedIndex, onPlanSelected: () {
          setState(() {
            selectedIndex = index;
          });
        },);
    });
  }
}