import 'package:bailbooks_defendant/ui/widgets/gradient_border_button.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/dimens.dart';
import '../../../../util/size/size_config.dart';
import '../../../../util/ui/ui_helper.dart';
import '../../../../widgets/divider_widget.dart';
import '../../../../widgets/main_button.dart';
import '../../../../widgets/text_widget.dart';
import '../../components/prediction_bottom_sheet.dart';

class OfflineMatchWidget extends StatelessWidget {
  OfflineMatchWidget({
    Key? key,
  }) : super(key: key);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Column(children: [
      const DividerWidget(),
      Container(
        width: SizeConfig.width * 100,
        margin: const EdgeInsets.only(bottom: 40),
        height: SizeConfig.height * 30,
        color: AppColors.textFieldColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(Assets.icSoccer),
          UIHelper.verticalSpaceMedium,
          const TextWidget(text: "Match to start yet",
          textSize: Dimens.textSM,
          color: AppColors.colorGrey,
          )
        ],)
        ,),
      SizedBox(
        width: SizeConfig.width * 90,
        child: MainButton(text: "Predict", onPressed: _showSheet,))
    ],);
  }

  void _showSheet() {
    showModalBottomSheet(context: _context,
    backgroundColor: AppColors.colorBackground,
    shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(20.0),
  ),
     builder: (context) {
      return const PredictionSheetWidget();
    });
  }
}



