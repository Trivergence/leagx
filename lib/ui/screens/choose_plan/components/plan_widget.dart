import 'package:leagx/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../../models/subscription_plan.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/gradient/gradient_widget.dart';
import '../../../widgets/text_widget.dart';
import 'desc_widget.dart';

class PlanWidget extends StatefulWidget {
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
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  bool isLoading = true;
  String? title;
  String? feature1;
  String? feature2;
  String? feature3;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Gradient gradient = getGradient(widget.index);
    return !isLoading ? GestureDetector(
      onTap: widget.onPlanSelected,
      child: Padding(
        padding: widget.index != 3
            ? const EdgeInsets.only(bottom: 60.0)
            : const EdgeInsets.only(bottom: 30.0),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            decoration: BoxDecoration(
                gradient: widget.isSelected ? gradient : null,
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
                              text: title!,
                              fontWeight: FontWeight.w700,
                              textSize: Dimens.textMedium,
                            ),
                          ),
                          widget.isAdmin
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
                                  text: feature1!,
                                  gradient: gradient,
                              ),
                              DescWidget(
                                  text: feature2!,
                                  gradient: gradient,
                              ),
                              DescWidget(
                                  text: feature3!,
                                  gradient: gradient,
                                )
                            ]
                          ),
                          GradientWidget(
                              gradient: gradient,
                              child: TextWidget(
                                text:
                                    "\$${widget.plan.price}",
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
    )
    : const ShimmerWidget(height: 120);
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

  Future<void> translateData() async {
    feature1 = await TranslationUtility.translate(widget.plan.feature1);
    feature2 = await TranslationUtility.translate(widget.plan.feature2);
    feature3 = await TranslationUtility.translate(widget.plan.feature3);
    title = await TranslationUtility.translate(widget.plan.title);
    isLoading = false;
    setState(() {});
  }
}
