import 'dart:async';

import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/subscription_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_models/subscription_viewmodel.dart';

enum LoginStatus { none, loggingIn, loggedIn, error }
enum SignupStatus { none, loading }

class SessionProvider extends ChangeNotifier {
  LoginStatus _loginStatus = LoginStatus.none;
  //SignupStatus _signupStatus = SignupStatus.none;
  SharedPreferences prefs;

  SessionProvider({required this.prefs});

  init(BuildContext context) async => await _loadSession(context);

  LoginStatus get loginStatus => _loginStatus;
  //SignupStatus get signupStatus => _signupStatus;

  Future<void> _loadSession(BuildContext context) async {
    if (ValidationUtils.isValid(locator<SharedPreferenceHelper>().authToken)) {
     _loginStatus = LoginStatus.loggedIn;
    }
    else if(!locator<SharedPreferenceHelper>().isFirstTime()) {
      _loginStatus = LoginStatus.error;
    }
    
    notifyListeners();
  }

  Future<dynamic> signIn(String username, String password) async {
    _loginStatus = LoginStatus.loggingIn;
    notifyListeners();
    try {
      Timer(const Duration(seconds: 3), () {
        _loginStatus = LoginStatus.loggedIn;
        notifyListeners();
      });
    } on Exception catch (e) {
      _loginStatus = LoginStatus.none;
      notifyListeners();
      return e;
    }
  }

  Future<void> signOut() async {
    _loginStatus = LoginStatus.none;
    SharedPreferenceHelper(prefs).removeAuthToken();
    SharedPreferenceHelper(prefs).removeUsername();
    notifyListeners();
  }
}