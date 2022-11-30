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
        child: Stack(
          clipBehavior: Clip.none, 
          children: [
          Container(
            decoration: BoxDecoration(
                color: widget.isSelected ? AppColors.colorPink : null,
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
                          TextWidget(
                            text: title!,
                            fontWeight: FontWeight.w700,
                            textSize: Dimens.textMedium,
                            color: AppColors.colorPink,
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
                          Expanded(
                            flex: 7,
                            child: Column(
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
                          ),
                          Expanded(
                            flex: 2,
                            child: TextWidget(
                              text:
                                  "\$${widget.plan.price}",
                              textSize: Dimens.textLarge,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.end,
                              color: AppColors.colorPink,
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
          Positioned(
              left: 29,
              top: -28,
              child: Image.asset(Assets.icCrown,
                      color: AppColors.colorPink,
                    ))
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
    String originalCommaText = widget.plan.feature1 + ',' + widget.plan.feature2 + ',' + widget.plan.feature3 + "," + widget.plan.title;
    String translatedCommaText =
        await TranslationUtility.translate(originalCommaText);
    List<String> listOfValues = [];
    if (translatedCommaText.contains("،")) {
      listOfValues = translatedCommaText.split("،");
    } else {
      listOfValues = translatedCommaText.split(",");
    }
    feature1 = listOfValues[0];
    feature2 = listOfValues[1];
    feature3 = listOfValues[2];
    title = listOfValues[3];
    isLoading = false;
    setState(() {});
  }
}
