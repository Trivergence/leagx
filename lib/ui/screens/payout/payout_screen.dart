import 'package:flutter/material.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';

class PayoutScreen extends StatelessWidget {
  const PayoutScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Payout"),
      body: Column(
        children: [
          SizedBox(
            width: 200,
            child: MainButton(text: "Withdraw", onPressed: () {})),
          UIHelper.verticalSpaceLarge,
          Card(
              color: AppColors.textFieldColor,
              elevation: 15,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)
            )
          ),
          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                         Icon(Icons.install_desktop),
                         TextWidget(text: "**** **** ****"),
                      ],
                    ),
                    UIHelper.horizontalSpaceSmall,
                    const TextWidget(text: "01/12")
                ]),
          ),
          ),
          MainButton(text: "Add Bank", onPressed: () {})
        ],
      ),
    );
  }
}