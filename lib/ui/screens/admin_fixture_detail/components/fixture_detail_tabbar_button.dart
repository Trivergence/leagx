import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
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
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44.0,
          decoration: BoxDecoration(
            gradient: AppColors.blackishGradient,
          ),
          child: isTapped
              ? Expanded(
                  child: GradientWidget(
                    child: Container(
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
