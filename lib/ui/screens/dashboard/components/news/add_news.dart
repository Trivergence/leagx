import 'package:flutter/services.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui/validation_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/search_textfield.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class AddNewsScreen extends StatefulWidget {

  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {

  final TextEditingController _messageController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late BuildContext _context;

  Map<String, String>? fixutrePayload;

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
                  text: loc.dashboardNewsAddNewsTxtDetails,
                  textSize: 16.0,
                ),
                UIHelper.verticalSpace(8.0),
                TextFieldWidget(
                  textController: _messageController,
                  listOfFormaters: [
                    FilteringTextInputFormatter.deny(",")
                  ],
                  inputAction: TextInputAction.newline,
                  maxLines: 10,
                  validator: (text) => ValidationHelper.validateField(text),
                ),
                UIHelper.verticalSpace(15.0),
                 TextWidget(
                  text: loc.dashboardNewsAddNewsTxtChooseFixture,
                  textSize: 16.0,
                ),
                UIHelper.verticalSpace(8.0),
                SearchTextField(
                  textController: _searchController,
                  hint: fixutrePayload == null ? loc.dashboardNewsAddNewsTxtSearch : null,
                  isDisabled: true,
                  onTap: _chooseFixture,
                ),
                UIHelper.verticalSpaceXL,
                Center(
                  child: MainButton(
                    text: loc.dashboardNewsAddNewsBtnSubmit,
                    onPressed: _addNews
                  ),
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
      if(fixutrePayload != null) {
        _context.read<DashBoardViewModel>().addNews(
          context: _context,
          desc: _messageController.text,
          matchId: fixutrePayload!["matchId"]!,
          leagueId: fixutrePayload!["leagueId"]!);
      } else {
        ToastMessage.show(loc.dashboardNewsAddNewsTxtRequiredFixture, TOAST_TYPE.msg);
      }

    }
  }

  Future<void> _chooseFixture() async {
    var payload = await Navigator.of(_context).pushNamed(Routes.chooseFixture);
    if(payload != null) {
      setState(() {
        fixutrePayload = payload as Map<String, String>;
        _searchController.text = fixutrePayload!["vsTitle"]!;
      });
    }
  }
}
