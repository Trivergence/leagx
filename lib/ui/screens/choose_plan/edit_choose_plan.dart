import 'package:bailbooks_defendant/constants/colors.dart';
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
        title: 'Edit Plan',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Name',
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(
              textController: _nameController,
              hint: 'Plan Name',
              readOnly: true,
              hintColor: AppColors.colorWhite.withOpacity(0.3),
            ),
            UIHelper.verticalSpaceSmall,
            const TextWidget(
              text: 'Price',
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(
              textController: _priceController,
              hint: 'Price',
            ),
            const TextWidget(
              text: 'Feature',
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(
              textController: _feature1Controller,
              hint: '1-Feature',
            ),
            UIHelper.verticalSpaceSmall,
            TextFieldWidget(
              textController: _feature2Controller,
              hint: '2-Feature',
            ),
            UIHelper.verticalSpaceSmall,
            TextFieldWidget(
              textController: _feature3Controller,
              hint: '3-Feature',
            ),
            UIHelper.verticalSpaceXL,
            MainButton(
              text: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
