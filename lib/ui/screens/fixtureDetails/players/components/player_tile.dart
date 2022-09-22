import 'package:leagx/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/size/size_config.dart';

import '../../../../../constants/colors.dart';
import '../../../../util/ui/ui_helper.dart';
import '../../../../widgets/gradient/gradient_border_widget.dart';
import '../../../../widgets/text_widget.dart';

class PlayerTile extends StatelessWidget {
  final String playerOneName;
  final String playerOneImg;
  final String playerTwoName;
  final String playerTwoImg;
  const PlayerTile({
    Key? key, required this.playerOneName, required this.playerOneImg, required this.playerTwoName, required this.playerTwoImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                GradientBorderWidget(
                  width: 44.0,
                  height: 44.0,
                  isCircular: true,
                  imageUrl: playerOneImg,
                  onPressed: () {},
                  gradient: AppColors.orangishGradient,
                ),
                UIHelper.horizontalSpaceSmall,
                TextWidget(
                  text: playerOneName,
                  color: AppColors.colorYellow,
                  maxLines: 1,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextWidget(
                  text: playerTwoName,
                  color: AppColors.colorRed,
                ),
                UIHelper.horizontalSpaceSmall,
                GradientBorderWidget(
                  width: 44.0,
                  height: 44.0,
                  isCircular: true,
                  imageUrl: playerTwoImg,
                  onPressed: () {},
                  gradient: AppColors.orangishGradient,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
