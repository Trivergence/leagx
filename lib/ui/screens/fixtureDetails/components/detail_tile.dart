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
  final Color tileColor;
  final String leftValue;
  final String rightValue;

  @override
  State<DetailTile> createState() => _DetailTileState();
}

class _DetailTileState extends State<DetailTile> {
  String? title;
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
          TextWidget(text: widget.leftValue, color: AppColors.colorYellow,),
          TextWidget(text: title!),
          TextWidget(text: widget.rightValue,
            color: AppColors.colorRed,
            textAlign: TextAlign.end,
          ),
      ],),
    )
    : const ShimmerWidget(height: 40, verticalPadding: 0, horizontalPadding: 0,)
    ;
  }

  Future<void> translateData() async {
    title =
        await TranslationUtility.translate(widget.title);
    isLoading = false;
    setState(() {});
  }
}