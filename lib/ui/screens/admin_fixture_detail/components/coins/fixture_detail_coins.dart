import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/screens/admin_fixture_detail/components/coins/components/coins_textfield.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/checkbox/check_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextWidget(
              text:
                  'Please select the coins that you want to distribut among winners, coins would be distributed in a way that the users with maximum prediction success rate would be earning more coins.',
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
                  hint: '1000',
                  suffix: const GradientWidget(
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 24.0,
                    ),
                  ),
                ),
                const GradientWidget(
                    gradient: AppColors.blueishGradient,
                    child: Divider(
                      height: 3,
                      thickness: 3,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          UIHelper.verticalSpace(8.0),
          const GradientWidget(
            child: TextWidget(
              text: 'Coins',
              textSize: 20.0,
            ),
          ),
          UIHelper.verticalSpace(60.0),
          Row(
            children: [
              CheckWidget(
                onChanged: (value) {},
              ),
              UIHelper.horizontalSpace(8.0),
              const TextWidget(
                text: 'Primary Match',
                textSize: 16.0,
              ),
            ],
          ),
          UIHelper.verticalSpaceLarge,
          MainButton(
            text: 'Save',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
