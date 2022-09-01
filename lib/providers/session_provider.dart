import 'dart:async';

import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginStatus { none, loggingIn, loggedIn, error }
enum SignupStatus { none, loading }

class SessionProvider extends ChangeNotifier {
  LoginStatus _loginStatus = LoginStatus.none;
  //SignupStatus _signupStatus = SignupStatus.none;
  SharedPreferences prefs;

  SessionProvider({required this.prefs});

  init() async {
    if (ValidationUtils.isValid(SharedPreferenceHelper(prefs).authToken)) {
      _loadSession();
    }
  }

  LoginStatus get loginStatus => _loginStatus;
  //SignupStatus get signupStatus => _signupStatus;

  void _loadSession() {
    //_loginStatus = LoginStatus.loading;
    //notifyListeners();

    Timer(const Duration(seconds: 3), () {
      _loginStatus = LoginStatus.loggedIn;
      notifyListeners();
    });

    //_loginStatus = LoginStatus.None;
    //notifyListeners();
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
