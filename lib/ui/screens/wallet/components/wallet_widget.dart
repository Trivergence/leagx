import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../models/user_summary.dart';
import '../../../util/locale/localization.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/text_widget.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    Key? key,
    required this.userSummary,
  }) : super(key: key);

  final UserSummary? userSummary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        color: AppColors.textFieldColor,
        elevation: 15,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: loc.walletTxtTotalCoins,
                color: AppColors.colorWhite,
                fontWeight: FontWeight.w700,
              ),
              UIHelper.verticalSpaceSmall,
              TextWidget(
                text: userSummary != null
                    ? userSummary!.coinEarned!.round().toString()
                    : "0.0",
                textSize: 27,
                fontWeight: FontWeight.w700,
              ),
              UIHelper.verticalSpaceMedium,
              // MainButton(
              //   width: 150,
              //   text: "Add Funds", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
