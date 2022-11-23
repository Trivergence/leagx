import 'package:flutter/material.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';
import 'package:leagx/ui/util/utility/image_utitlity.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../screens/dashboard/components/news/components/tick_widget.dart';
import '../util/ui/ui_helper.dart';
import '../util/utility/translation_utility.dart';
import 'gradient/gradient_border_widget.dart';
import 'text_widget.dart';

class NewsTile extends StatefulWidget {
  final String? imageUrl;
  final String postedBy;
  final DateTime when;
  final String desc;
  final bool isApproval;
  const NewsTile({
    Key? key, this.imageUrl, required this.postedBy, required this.when,required this.desc, this.isApproval = false,
  }) : super(key: key);

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  String? desc;
  String? postedBy;
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = context.read<LocalizationProvider>().getLocale;
    return !isLoading ? Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      margin: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        gradient: AppColors.blackishGradient,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Column(
          children: [
            GradientBorderWidget(
            width: 35.0,
            height: 35.0,
            isCircular: true,
            imageUrl: widget.imageUrl,
            onPressed: () {},
            gradient: AppColors.orangishGradient,
            placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
            isBorderSolid: true,
          ),
          ],
        ),
        UIHelper.horizontalSpace(10),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                TextWidget(text: postedBy!),
                TextWidget(text: DateUtility.getRemainingTime(widget.when, locale),
                textSize: Dimens.textXS,
                color: widget.isApproval == true ? AppColors.colorCyan : AppColors.colorYellow,)
              ],),
              UIHelper.verticalSpace(11),
              Row(
                children: [
                Expanded(
                  child: TextWidget(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w300,
                  textSize: Dimens.textXS,
                  color: AppColors.colorWhite.withOpacity(0.7),
                  text: desc!)),
                if (widget.isApproval) UIHelper.horizontalSpace(9),
                if (widget.isApproval) const TickWidget(isApproved: false)
              ],)
            ],
          ),
        )
      ],),
    )
    : const ShimmerWidget(
        height: 100,
        horizontalPadding: 15,
        verticalPadding: 15,
      )
    ;
  }

  Future<void> translateData() async {
    String originalCommaText = widget.desc + ',' + widget.postedBy;
    String translatedCommaText = await TranslationUtility.translate(originalCommaText);
    List<String> listOfValues = [];
    if (translatedCommaText.contains("،")) {
      listOfValues = translatedCommaText.split("،");
    } else {
      listOfValues = translatedCommaText.split(",");
    }
    desc = listOfValues[0];
    postedBy = listOfValues[1];
    isLoading = false;
    setState(() {});
  }
}