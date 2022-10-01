import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:leagx/ui/util/toast/toast.dart';

import '../../ui/util/locale/localization.dart';

class InternetInfo {
  static Future<bool> isConnected() async {
    bool connection = true;
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        connection = true;
        break;
      case ConnectivityResult.mobile:
        connection = true;
        break;
      case ConnectivityResult.none:
        connection = false;
        showToast();
        break;
      case ConnectivityResult.bluetooth:
        connection = false;
        showToast();
        break;
      case ConnectivityResult.ethernet:
        connection = false;
        showToast();
        break;
    }
    return connection;
  }

  static void showToast() {
    ToastMessage.show(loc.errorCheckNetwork, TOAST_TYPE.error);
  }
}
