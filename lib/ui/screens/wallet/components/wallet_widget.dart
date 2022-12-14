import 'package:flutter/material.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_button.dart';

import '../../../../constants/colors.dart';
import '../../../../core/network/internet_info.dart';
import '../../../../models/user_summary.dart';
import '../../../../routes/routes.dart';
import '../../../util/locale/localization.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/text_widget.dart';

// ignore: must_be_immutable
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: loc.walletTxtTotalCoins,
                    color: AppColors.colorWhite,
                    fontWeight: FontWeight.w600,
                  ),
                  GradientBorderButton(
                    fontSize: Dimens.textXS,
                    height: 25,
                    width: 100,
                    text: loc.walletBtnRedeem,
                    onPressed: () async {
                      bool isConnected = await InternetInfo.isConnected();
                      if (isConnected == true) {
                        Navigator.pushNamed(context, Routes.chooseLeague,
                            arguments: true);
                      }
                    },
                  )
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: userSummary != null
                        ? userSummary!.coinEarned!.round().toString()
                        : "0.0",
                    textSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  GradientBorderButton(
                      fontSize: Dimens.textXS,
                      height: 25,
                      width: 100,
                      text: loc.walletBtnWithdraw,
                      onPressed: () async {
                        bool isConnected = await InternetInfo.isConnected();
                        if (isConnected == true) {
                          Navigator.of(context).pushNamed(Routes.payout);
                        }
                      })
                ],
              ),
              // UIHelper.verticalSpaceMedium,
              // MainButton(
              //   width: 150,
              //   text: loc.walletBtnAddCoins, onPressed: _showDialog)
            ],
          ),
        ),
      ),
    );
  }

  // void _showDialog() {
  //   FormDialog.show(
  //     context: _context,
  //     type: DialogType.addCoins,
  //     title: loc.walletAddCoinDialogTitle,
  //     body: loc.walletAddCoinDialogBody,
  //     negativeBtnTitle: loc.walletAddCoinDialogBtnNegative,
  //     positiveBtnTitle: loc.walletAddCoinDialogBtnPositive,
  //     onPositiveBtnPressed: (coins,_) async {
  //       Loader.showLoader();
  //       bool success = await _context.read<WalletViewModel>().purchaseCoin(coins);
  //       if(success == true) {
  //         await _context.read<DashBoardViewModel>().getUserSummary();
  //       }
  //       Loader.hideLoader();
  //     });
  // }
}
