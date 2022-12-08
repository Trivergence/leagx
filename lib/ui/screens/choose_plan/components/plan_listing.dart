import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../models/subscription_plan.dart';
import '../../../../models/user_summary.dart';
import '../../../../view_models/subscription_viewmodel.dart';
import '../../../widgets/placeholder_tile.dart';
import 'plan_widget.dart';

// ignore: must_be_immutable
class PlanListing extends StatelessWidget {
  final bool isAdmin;
  final Function(int, String) onItemPressed;

  PlanListing({
    required this.isAdmin,
    Key? key, required this.onItemPressed,
  }) : super(key: key);

  late List<SubscriptionPlan> listOfPlans;
  UserSummary? _userSummary;

  @override
  Widget build(BuildContext context) {
    listOfPlans = context.read<SubscriptionViewModel>().getPlans;
    _userSummary = context.read<DashBoardViewModel>().userSummary;
    return listOfPlans.isNotEmpty ? ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: listOfPlans.length,
      itemBuilder: (context, index) {
        return PlanWidget(
         plan: listOfPlans[index],
         isAdmin: false,
         index: index,
         isSelected: _userSummary != null && _userSummary!.currentPlan != null ? listOfPlans[index].id == _userSummary!.currentPlan!.id : false, 
         onPlanSelected: () {
          onItemPressed(listOfPlans[index].id, listOfPlans[index].price.toStringAsFixed(0));
        },);
    })
    :Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: PlaceHolderTile(height: 60, msgText: loc.errorCheckNetwork),
      )
    ;
  }
}