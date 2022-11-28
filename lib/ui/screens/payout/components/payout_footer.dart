import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/colors.dart';
import '../../../../core/utility.dart';
import '../../../util/locale/localization.dart';
import '../../../widgets/text_widget.dart';

class PayoutFooter extends StatelessWidget {
  const PayoutFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        width: double.infinity,
        color: AppColors.textFieldColor,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: TextWidget(
                text: loc.errorPayoutNotAvailable,
                color: AppColors.colorRed,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () async =>
                          await Utility.openUrl(url: AppConstants.payoutUrl),
                      child: TextWidget(text: loc.payoutBtnDetails)),
                ))
          ],
        ),
      ),
    );
  }
}
