import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/search_textfield.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class AddNewsScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  AddNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(title: 'Add News'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Title',
              textSize: 16.0,
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(
              textController: _titleController,
            ),
            UIHelper.verticalSpace(15.0),
            const TextWidget(
              text: 'Details',
              textSize: 16.0,
            ),
            UIHelper.verticalSpace(8.0),
            TextFieldWidget(textController: _messageController,inputAction: TextInputAction.newline,maxLines: 6,),
            UIHelper.verticalSpace(15.0),
            const TextWidget(
              text: 'Choose a Fixture',
              textSize: 16.0,
            ),
            UIHelper.verticalSpace(8.0),
            SearchTextField(textController: _searchController, hint: 'Search',),
            UIHelper.verticalSpaceXL,
            MainButton(text: 'Submit', onPressed: (){},),
          ],
        ),
      ),
    );
  }
}
