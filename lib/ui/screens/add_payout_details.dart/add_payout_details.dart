import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddPayoutDetails extends StatelessWidget {
  final String accountLink;
  const AddPayoutDetails({ Key? key, required  this.accountLink }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Add Details",),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: accountLink),
    );
  }
}