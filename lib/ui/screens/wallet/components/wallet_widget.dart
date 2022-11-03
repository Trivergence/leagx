import 'package:flutter/material.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/ui/util/app_dialogs/form_dialog.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../models/user_summary.dart';
import '../../../util/locale/localization.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';

// ignore: must_be_immutable
class WalletWidget extends StatelessWidget {
 WalletWidget({
    Key? key,
    required this.userSummary,
  }) : super(key: key);

  final UserSummary? userSummary;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
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
              MainButton(
                width: 150,
                text: loc.walletBtnAddCoins, onPressed: _showDialog)
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    FormDialog.show(
      context: _context, 
      type: DialogType.addCoins,
      title: loc.walletAddCoinDialogTitle,
      body: loc.walletAddCoinDialogBody,
      negativeBtnTitle: loc.walletAddCoinDialogBtnNegative, 
      positiveBtnTitle: loc.walletAddCoinDialogBtnPositive, 
      onPositiveBtnPressed: (coins) async {
        Loader.showLoader();
        bool success = await _context.read<WalletViewModel>().purchaseCoin(coins);
        if(success == true) {
          await _context.read<DashBoardViewModel>().getUserSummary();
        }
        Loader.hideLoader();
      });
  }
}
