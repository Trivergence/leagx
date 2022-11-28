import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/text_widget.dart';

class CardInfoWidget extends StatelessWidget {
  final String last4;
  final String expMonth;
  final String expYear;
  const CardInfoWidget({
    Key? key,
    required this.last4, required this.expMonth, required this.expYear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.textFieldColor,
      elevation: 15,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              const Icon(Icons.payment),
              UIHelper.horizontalSpaceSmall,
              TextWidget(
                  text: UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet + " " 
                  + UIHelper.bullet 
                  + UIHelper.bullet
                  + UIHelper.bullet 
                  + UIHelper.bullet + " "
                  + UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet 
                  + UIHelper.bullet + " "
                  + last4),
            ],
          ),
          UIHelper.horizontalSpaceSmall,
          TextWidget(
              text: expMonth +
                  "/" +
                  expYear)
        ]),
      ),
    );
  }
}
