import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/subscription_plan.dart';
import '../../../../view_models/choose_plan_viewmodel.dart';
import 'plan_widget.dart';

class PlanListing extends StatefulWidget {
  final bool isAdmin;
  final Function(int) onItemPressed;

  const PlanListing({
    required this.isAdmin,
    Key? key, required this.onItemPressed,
  }) : super(key: key);

  @override
  State<PlanListing> createState() => _PlanListingState();
}

class _PlanListingState extends State<PlanListing> {
  int selectedIndex = 1;
  late List<SubscriptionPlan> listOfPlans;

  @override
  Widget build(BuildContext context) {
    listOfPlans = context.read<ChoosePlanViewModel>().getPlans;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: listOfPlans.length,
      itemBuilder: (context, index) {
        return PlanWidget(
          plan: listOfPlans[index],
         isAdmin: false,
         index: index,
         isSelected: index == selectedIndex, onPlanSelected: () {
          setState(() {
            selectedIndex = index;
          });
          widget.onItemPressed(listOfPlans[index].id);
        },);
    });
  }
}