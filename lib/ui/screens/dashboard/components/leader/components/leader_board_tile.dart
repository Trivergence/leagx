import 'package:leagx/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/image_utitlity.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

import '../../../../../util/utility/translation_utility.dart';

class LeaderBoardTile extends StatefulWidget {
  final int number;
  final String imageUrl;
  final String title;
  final int numberOfPrediciton;
  final String successRate;

  const LeaderBoardTile({
    Key? key,
    required this.number,
    required this.imageUrl,
    required this.title,
    required this.numberOfPrediciton,
    required this.successRate,
  }) : super(key: key);

  @override
  State<LeaderBoardTile> createState() => _LeaderBoardTileState();
}

class _LeaderBoardTileState extends State<LeaderBoardTile> {
  bool isLoading = true;
  String? leaderName;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading ? Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        gradient: AppColors.blackishGradient,
      ),
      child: Row(
        children: [
          GradientBorderWidget(
            width: 20.0,
            height: 20.0,
            isCircular: true,
            gradient: AppColors.grayishGradient,
            text: widget.number.toString(),
            textSize: 12.0,
            onPressed: () {},
          ),
          UIHelper.horizontalSpace(15.0),
          GradientBorderWidget(
            width: 44.0,
            height: 44.0,
            isCircular: true,
            imageUrl: widget.imageUrl,
            placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
            onPressed: () {},
            gradient: AppColors.orangishGradient,
          ),
          UIHelper.horizontalSpace(15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: leaderName!),
                    TextWidget(
                      text: '${widget.successRate}%',
                      color: AppColors.colorGreen,
                      textSize: Dimens.textXM,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: '${widget.numberOfPrediciton} ${loc.dashboardLeaderTxtPredictions}',
                      textSize: Dimens.textSmall,
                      color: AppColors.colorWhite.withOpacity(0.5),
                    ),
                     TextWidget(
                      text: loc.dashboardLeaderTxtSuccess,
                      textSize: Dimens.textSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ) : const ShimmerWidget(height: 100);
  }

  Future<void> translateData() async {
      leaderName = await TranslationUtility.translate(widget.title);
      isLoading = false;
      setState(() {});
  }
}
