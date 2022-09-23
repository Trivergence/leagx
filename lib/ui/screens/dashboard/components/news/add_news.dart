import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class AddNewsScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BuildContext? _context;

  AddNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(title: loc.dashboardNewsAddNewsTxtAddNews),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 TextWidget(
                  text: loc.dashboardNewsAddNewsTxtTitle,
                  textSize: 16.0,
                ),
                UIHelper.verticalSpace(8.0),
                TextFieldWidget(
                  textController: _titleController,
                  validator: (text) {
                    if(!ValidationUtils.isValid(text)) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(15.0),
                 TextWidget(
                  text: loc.dashboardNewsAddNewsTxtDetails,
                  textSize: 16.0,
                ),
                UIHelper.verticalSpace(8.0),
                TextFieldWidget(
                  textController: _messageController,
                  inputAction: TextInputAction.newline,
                  maxLines: 6,
                  validator: (text) {
                    if (!ValidationUtils.isValid(text)) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(15.0),
                 TextWidget(
                  text: loc.dashboardNewsAddNewsTxtChooseFixture,
                  textSize: 16.0,
                ),
                UIHelper.verticalSpace(8.0),
                SearchTextField(
                  textController: _searchController,
                  hint: loc.dashboardNewsAddNewsTxtSearch,
                  isDisabled: true,
                  onTap: _chooseFixture,
                ),
                UIHelper.verticalSpaceXL,
                MainButton(
                  text: loc.dashboardNewsAddNewsBtnSubmit,
                  onPressed: _addNews
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addNews() {
    bool isValid = _formKey.currentState!.validate();
    if(isValid) {

    }
  }

  Future<void> _chooseFixture() async {
    await Navigator.of(_context!).pushNamed(Routes.chooseFixture);
  }
}
