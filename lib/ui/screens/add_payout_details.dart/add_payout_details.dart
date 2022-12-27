import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:payments/constants/payment_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddPayoutDetails extends StatefulWidget {
  final String accountLink;
  const AddPayoutDetails({Key? key, required this.accountLink})
      : super(key: key);

  @override
  State<AddPayoutDetails> createState() => _AddPayoutDetailsState();
}

class _AddPayoutDetailsState extends State<AddPayoutDetails> {
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.addPayoutTxtTitle,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.accountLink,
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onProgress: (_) async {
          if (_webViewController != null) {
            String? url = await _webViewController!.currentUrl();
            if (url != null && url == PaymentConstants.returnUrl) {
              Navigator.of(context).pop();
            }
          }
        },
      ),
    );
  }
}
