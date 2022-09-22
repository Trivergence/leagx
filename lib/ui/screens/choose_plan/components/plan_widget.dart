import 'package:leagx/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../../models/subscription_plan.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/gradient/gradient_widget.dart';
import '../../../widgets/text_widget.dart';
import 'desc_widget.dart';

class PlanWidget extends StatelessWidget {
  final SubscriptionPlan plan;
  final int index;
  final bool isSelected;
  final VoidCallback onPlanSelected;
  final bool isAdmin;
  const PlanWidget({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.onPlanSelected,
    required this.isAdmin, required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Gradient gradient = getGradient(index);
    return GestureDetector(
      onTap: onPlanSelected,
      child: Padding(
        padding: index != 3
            ? const EdgeInsets.only(bottom: 60.0)
            : const EdgeInsets.only(bottom: 30.0),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            decoration: BoxDecoration(
                gradient: isSelected ? gradient : null,
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
                            gradient: gradient,
                            child: TextWidget(
                              text: plan.title,
                              fontWeight: FontWeight.w700,
                              textSize: Dimens.textMedium,
                            ),
                          ),
                          isAdmin
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.editChoosePlan);
                                  },
                                  child: Image.asset(Assets.icEdit),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      UIHelper.verticalSpace(13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DescWidget(
                                  text: plan.feature1,
                                  gradient: gradient,
                              ),
                              DescWidget(
                                  text: plan.feature2,
                                  gradient: gradient,
                              ),
                              DescWidget(
                                  text: plan.feature2,
                                  gradient: gradient,
                                )
                            ]
                          ),
                          GradientWidget(
                              gradient: gradient,
                              child: TextWidget(
                                text:
                                    "\$${plan.price}",
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
                  gradient: gradient,
                  child: Image.asset(Assets.icCrown)))
        ]),
      ),
    );
  }

  Gradient getGradient(int index) {
    switch(index){
      case 0:
        return AppColors.blueishBottomTopGradient;
      case 1:
        return AppColors.orangishGradient;
      case 2:
        return AppColors.pinkishGradient;
      case 3:
        return AppColors.blueishGradient;
      default:
        return AppColors.blueishBottomTopGradient;
    }
  }
}
