import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader{
  static void showLoader(){
    EasyLoading.show(status: 'loading');
  }
  static void hideLoader(){
    EasyLoading.dismiss();
  }
}