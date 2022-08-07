import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:flutter/material.dart';
class HaveAccountButton extends StatelessWidget {
  final String subText;
  final VoidCallback onTap;
  const HaveAccountButton({Key? key , required this.subText,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text:  TextSpan(
            text: "Don't have an account? ",
            style:const TextStyle(
              color: AppColors.colorGrey,
              fontSize: Dimens.textRegular,
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: subText,
                style:const TextStyle(
                  color: Color(0xFF71DBD4),
                  fontSize: Dimens.textRegular,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                ),
              )
            ]

        ),
      ),
    );
  }
}
