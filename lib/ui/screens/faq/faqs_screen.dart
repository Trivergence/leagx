import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/screens/faq/components/faqs_tile.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'FAQs',
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.verticalPadding,
          horizontal: 16.0,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1B1F2A),
              Color(0xFF28314A),
              Color(0xFF1B1F2A),
            ],
          ),
        ),
        child: Column(
          children: [
            const GradientWidget(
              child: TextWidget(
                text: 'How Lorem ipsum dolor  ',
                fontWeight: FontWeight.w600,
                textSize: 20.0,
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const FaqTile(
                    title: ' Vestibulum ex odio, vehicula eu?',
                    subtitle:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus erat turpis, congue eu interdum non, rhoncus quis massa. ',
                  );
                },
              ),
            ),
            // FaqTile(
            //   title: 'Lorem ipsum dolor sit amet?',
            // ),
            // FaqTile(
            //   title: ' Vestibulum ex odio, vehicula eu?',
            //   subtitle:
            //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus erat turpis, congue eu interdum non, rhoncus quis massa. ',
            // ),
          ],
        ),
      ),
    );
  }
}
