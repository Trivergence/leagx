import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/locale/localization.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class EditChoosePlanScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _feature1Controller = TextEditingController();
  final TextEditingController _feature2Controller = TextEditingController();
  final TextEditingController _feature3Controller = TextEditingController();

  EditChoosePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.editChoosePlanTxtEditPlan,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             TextWidget(
              text: loc.editChoosePlanTxtName,
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(
              textController: _nameController,
              hint: loc.editChoosePlanTxtPlanName,
              readOnly: true,
              hintColor: AppColors.colorWhite.withOpacity(0.3),
            ),
            UIHelper.verticalSpaceSmall,
             TextWidget(
              text: loc.editChoosePlanTxtPrice,
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(
              textController: _priceController,
              hint: loc.editChoosePlanTxtPrice,
            ),
             TextWidget(
              text: loc.editChoosePlanTxtFeature,
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(
              textController: _feature1Controller,
              hint: loc.editChoosePlanTxt1Feature,
            ),
            UIHelper.verticalSpaceSmall,
            TextFieldWidget(
              textController: _feature2Controller,
              hint: loc.editChoosePlanTxt2Feature,
            ),
            UIHelper.verticalSpaceSmall,
            TextFieldWidget(
              textController: _feature3Controller,
              hint: loc.editChoosePlanTxt3Feature,
            ),
            UIHelper.verticalSpaceXL,
            MainButton(
              text: loc.editChoosePlanBtnSave,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
