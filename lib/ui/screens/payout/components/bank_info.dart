import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../util/locale/localization.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/text_widget.dart';

class BankInfoWidget extends StatelessWidget {
  const BankInfoWidget({
    Key? key,
    required this.bankName,
    required this.currency,
    required this.routingNumber,
    required this.last4,
  }) : super(key: key);

  final String? bankName;
  final String? currency;
  final String? routingNumber;
  final String? last4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextWidget(
            text: loc.payoutTxtAttachedBank,
            textSize: 18,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.start,
          ),
          UIHelper.verticalSpaceSmall,
          Card(
            color: AppColors.textFieldColor,
            elevation: 15,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance,
                    size: 40,
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWidget(text: bankName!),
                          UIHelper.horizontalSpaceSmall,
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              color: AppColors.colorBackground,
                              child: TextWidget(
                                text: currency!,
                                textSize: Dimens.textXS,
                              ),
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall,
                          const CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.colorGreen,
                              child: Center(
                                  child: Icon(
                                Icons.done,
                                color: AppColors.colorWhite,
                                size: 10,
                              )))
                        ],
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: routingNumber!,
                            textSize: Dimens.textSmall,
                          ),
                          UIHelper.horizontalSpaceSmall,
                          TextWidget(
                              text: UIHelper.bullet +
                                  UIHelper.bullet +
                                  UIHelper.bullet +
                                  UIHelper.bullet +
                                  " " +
                                  last4!),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
