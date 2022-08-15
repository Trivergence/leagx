import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TermsServiceScreen extends StatelessWidget {
  const TermsServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Terms of Services',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1B1F2A),
                      Color(0xFF28314A),
                      Color(0xFF1B1F2A),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.verticalPadding, horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      GradientWidget(
                        child: TextWidget(
                          text: 'How Lorem ipsum dolor  ',
                          fontWeight: FontWeight.w600,
                          textSize: 20.0,
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      TextWidget(
                        text:
                            """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus erat turpis, congue eu interdum non, rhoncus quis massa. Donec leo dolor, interdum id eleifend non, gravida nec. Donec sed justo eget tellus condimentum efficitur ac quis nisi. Aliquam ut tristique lectus, varius vulputate metus. Cras in tincidunt ipsum. Integer sollicitudin ullamcorper. Cras a urna ultricies nisl ultricies viverra. Fusce eros turpis, eleifend interdum imperdiet eget, maximus eget nulla.

Morbi non dui dui. Donec elementum neque blandit, pulvinar leo ut, placerat tortor. Vitae ipsum id elit efficitur tempor. Cras enim augue,  ullamcorper enim in, efficitur rhoncus felis. Cras id suscipit leo. Integer egestas massa sit amet ullamcorper pharetra. Praesent sed nunc libero. Nunc volutpat hendrerit diam. Duis venenatis cursus urna, sit amet suscipit massa vulputate nec.
                  """,
                        color: AppColors.colorGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: MainButton(
                    text: 'Agree',
                    onPressed: () {
                      
                    },
                  ),
                ),
                UIHelper.horizontalSpaceMedium,
                Flexible(
                  child: GradientBorderWidget(
                    text: 'Deny',
                    onPressed: (){},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
