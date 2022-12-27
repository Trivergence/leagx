import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/screens/admin/admin_fixture_detail/components/coins/components/coins_textfield.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/checkbox/check_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FixtureDetailCoinsScreen extends StatelessWidget {
  final TextEditingController _coinsController = TextEditingController();
  FixtureDetailCoinsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          UIHelper.verticalSpace(45.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextWidget(
              text: loc.adminFixtureDetailCoinTxtSelectCoinDesc,
              textSize: 16.0,
              textAlign: TextAlign.center,
            ),
          ),
          UIHelper.verticalSpace(30.0),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                CoinsTextField(
                  textController: _coinsController,
                  inputType: TextInputType.number,
                  hint: loc.adminFixtureDetailCoinTxt1000,
                  suffix: const Icon(
                    Icons.info_outline_rounded,
                    size: 24.0,
                    color: AppColors.colorPink,
                  ),
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                  color: Colors.white,
                )
              ],
            ),
          ),
          UIHelper.verticalSpace(8.0),
          TextWidget(
            text: loc.adminFixtureDetailCoinTxtCoins,
            textSize: 20.0,
            color: AppColors.colorPink,
          ),
          UIHelper.verticalSpace(60.0),
          Row(
            children: [
              CheckWidget(
                onChanged: (value) {},
              ),
              UIHelper.horizontalSpace(8.0),
              TextWidget(
                text: loc.adminFixtureDetailCoinTxtPrimaryMatch,
                textSize: 16.0,
              ),
            ],
          ),
          UIHelper.verticalSpaceLarge,
          MainButton(
            text: loc.adminFixtureDetailCoinBtnSave,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
