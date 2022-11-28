import 'package:leagx/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';

import '../../../../../constants/colors.dart';
import '../../../../util/ui/ui_helper.dart';
import '../../../../widgets/gradient/gradient_border_widget.dart';
import '../../../../widgets/text_widget.dart';

class PlayerTile extends StatefulWidget {
  final String playerOneName;
  final String playerOneImg;
  final String playerTwoName;
  final String playerTwoImg;
  final Color tileColor;
  const PlayerTile({
    Key? key, required this.playerOneName, required this.playerOneImg, required this.playerTwoName, required this.playerTwoImg,required this.tileColor,
  }) : super(key: key);

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  String? playerOneName;
  String? playerTwoName;
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading ? Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: widget.tileColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                GradientBorderWidget(
                  width: 44.0,
                  height: 44.0,
                  isCircular: true,
                  imageUrl: widget.playerOneImg,
                  placeHolderImg: Assets.icPlayerAvatar,
                  onPressed: () {},
                  gradient: AppColors.orangishGradient,
                ),
                UIHelper.verticalSpaceSmall,
                TextWidget(
                  text: playerOneName!,
                  color: AppColors.colorYellow,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Center(
                child: Container(
                  height: 3,
                  width: 15,
                  color: AppColors.colorWhite,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                GradientBorderWidget(
                  width: 44.0,
                  height: 44.0,
                  isCircular: true,
                  imageUrl: widget.playerTwoImg,
                  placeHolderImg: Assets.icPlayerAvatar,
                  onPressed: () {},
                  gradient: AppColors.orangishGradient,
                ),
                UIHelper.verticalSpaceSmall,
                TextWidget(
                  text: playerTwoName!,
                  color: AppColors.colorRed,
                  textAlign: TextAlign.center,
                ),                
              ],
            ),
          ),
        ],
      ),
    ): const ShimmerWidget(height: 100);
  }

  Future<void> translateData() async {
    String originalCommaText = widget.playerOneName +
        "," +
        widget.playerTwoName;
    String translatedCommaText =
        await TranslationUtility.translate(originalCommaText);
    List<String> listOfValues = [];
    if (translatedCommaText.contains("،")) {
      listOfValues = translatedCommaText.split("،");
    } else {
      listOfValues = translatedCommaText.split(",");
    }
      playerOneName = listOfValues[0];
      playerTwoName = listOfValues[1];
      isLoading = false;
      setState(() {
      });
  }
}
