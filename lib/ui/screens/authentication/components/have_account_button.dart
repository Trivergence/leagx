import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:flutter/material.dart';

class HaveAccountButton extends StatelessWidget {
  final String mainText;
  final String subText;
  final VoidCallback onTap;
  const HaveAccountButton(
      {Key? key,
      required this.subText,
      required this.onTap,
      required this.mainText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
            text: mainText,
            style: const TextStyle(
              color: AppColors.colorGrey,
              fontSize: Dimens.textRegular,
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: subText,
                style: const TextStyle(
                  color: Color(0xFF71DBD4),
                  fontSize: Dimens.textRegular,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                ),
              )
            ]),
      ),
    );
  }
}
