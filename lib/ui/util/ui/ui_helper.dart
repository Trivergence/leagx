import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class UIHelper {
  static const Widget verticalSpaceSmall =
      SizedBox(height: Dimens.verticalSpaceSmall);
  static const Widget verticalSpaceMedium =
      SizedBox(height: Dimens.verticalSpaceMedium);
  static const Widget verticalSpaceLarge =
      SizedBox(height: Dimens.verticalSpaceLarge);
  static const Widget verticalSpaceXL = SizedBox(height:Dimens.verticalSpaceXL);    
  static Widget verticalSpace(double height) => SizedBox(height: height);

  static const Widget horizontalSpaceSmall =
      SizedBox(width: Dimens.horizontalSpaceSmall);
  static const Widget horizontalSpaceMedium =
      SizedBox(width: Dimens.horizontalSpaceMedium);
  static const Widget horizontalSpaceLarge =
      SizedBox(width: Dimens.horizontalSpaceLarge);

  static Widget horizontalSpace(double width) => SizedBox(width: width);

  static SizedBox get empty => const SizedBox();

  static switchFocus(BuildContext context, FocusNode current, FocusNode? next) {
    current.unfocus();
    if (next != null) FocusScope.of(context).requestFocus(next);
  }

  static Widget noItemFound(String msg) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(30.0),
      child: TextWidget(
        text: msg,
      ),
    );
  }

  static String bullet = '\u2022';
}
