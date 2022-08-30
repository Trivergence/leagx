import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../util/ui_model/subscription_plan.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/text_widget.dart';
import 'desc_widget.dart';

class PlanWidget extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onPlanSelected;
  final bool isAdmin;
  const PlanWidget({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.onPlanSelected,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlanSelected,
      child: Padding(
        padding: index != 3
            ? const EdgeInsets.only(bottom: 60.0)
            : const EdgeInsets.only(bottom: 30.0),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            decoration: BoxDecoration(
                gradient: isSelected ? listOfPlans[index].gradient : null,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(1.5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.zero,
              color: AppColors.textFieldColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0, top: 17.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientWidget(
                          gradient: listOfPlans[index].gradient!,
                          child: TextWidget(
                            text: listOfPlans[index].title!,
                            fontWeight: FontWeight.w700,
                            textSize: Dimens.textMedium,
                          ),),
                          isAdmin?GestureDetector(
                            onTap:(){
                              Navigator.pushNamed(context, Routes.editChoosePlan);
                            },
                            child: Image.asset(Assets.icEdit),
                          ):const SizedBox(),
                        ],
                      ),
                      UIHelper.verticalSpace(13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listOfPlans[index]
                                .desc!
                                .map((desc) => DescWidget(
                                      text: desc,
                                      index: index,
                                    ))
                                .toList(),
                          ),
                          GradientWidget(
                              gradient: listOfPlans[index].gradient!,
                              child: TextWidget(
                                text:
                                    "\$${listOfPlans[index].price!.toStringAsFixed(2)}",
                                textSize: Dimens.textLarge,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      )
                    ]),
              ),
            ),
          ),
          Positioned(
              left: 29,
              top: -28,
              child: GradientWidget(
                  gradient: listOfPlans[index].gradient!,
                  child: Image.asset(Assets.icCrown)))
        ]),
      ),
    );
  }
}
