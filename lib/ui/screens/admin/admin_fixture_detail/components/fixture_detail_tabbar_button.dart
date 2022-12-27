import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FixtureDetailTabbarButton extends StatelessWidget {
  final bool isTapped;
  final VoidCallback onTap;
  final String title;
  const FixtureDetailTabbarButton({
    Key? key,
    required this.title,
    required this.isTapped,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44.0,
          decoration: BoxDecoration(
            gradient: AppColors.blackishGradient,
          ),
          child: isTapped
              ? Container(
                color: AppColors.colorPink,
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    width: 2.0,
                  )),
                ),
                child: Center(
                  child: TextWidget(
                    text: title.toUpperCase(),
                    color: AppColors.colorWhite,
                    textSize: 16.0,
                  ),
                ),
              )
              : Center(
                  child: TextWidget(
                    text: title.toUpperCase(),
                    color: AppColors.colorWhite.withOpacity(0.5),
                    textSize: 16.0,
                  ),
                ),
        ),
      ),
    );
  }
}
