import 'package:flutter/material.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class DetailTile extends StatefulWidget {
  const DetailTile({
    Key? key,required this.title, required this.leftValue, required this.rightValue,required this.tileColor,
  }) : super(key: key);
  final String title;
  final String leftValue;
  final String rightValue;
  final Color tileColor;

  @override
  State<DetailTile> createState() => _DetailTileState();
}

class _DetailTileState extends State<DetailTile> {
  String? title;
  String? leftValue;
  String? rightValue;
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading ? Container(
      color: widget.tileColor,
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(text: leftValue!, color: AppColors.colorYellow,),
          TextWidget(text: title!),
          TextWidget(text: rightValue!,
            color: AppColors.colorRed,
            textAlign: TextAlign.end,
          ),
      ],),
    )
    : const ShimmerWidget(height: 40, verticalPadding: 0, horizontalPadding: 0,)
    ;
  }

  Future<void> translateData() async {
    title = await TranslationUtility.translate(widget.title);
    leftValue = await TranslationUtility.translate(widget.leftValue);
    rightValue = await TranslationUtility.translate(widget.rightValue);
    isLoading = false;
    setState(() {});
  }
}