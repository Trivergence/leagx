import 'dart:async';
import 'dart:convert';
import 'package:leagx/models/user/user.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';

import 'constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  // Token
  String? get authToken {
    String? token = _sharedPreference.getString(Preferences.authToken);
    return token;
  }

  Future<bool> saveAuthToken(String authToken) async {
    return await _sharedPreference.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.authToken);
  }

  Future<void> setFirstTime(bool value) async {
    await _sharedPreference.setBool(Preferences.firstTime, value);
  }

  bool isFirstTime() {
    return _sharedPreference.getBool(Preferences.firstTime) ?? true;
  }

  //Username
  String? get username => _sharedPreference.getString(Preferences.username);

  Future<bool> saveUsername(String username) async {
    return _sharedPreference.setString(Preferences.username, username);
  }

  Future<bool> removeUsername() async {
    return _sharedPreference.remove(Preferences.username);
  }

  //User
  User? getUser() {
    if (ValidationUtils.isValid(
        _sharedPreference.getString(Preferences.user))) {
      return User.fromJson(
          jsonDecode(_sharedPreference.getString(Preferences.user)!));
    } else {
      return null;
    }
  }

  Future<bool> saveUser(User user){
    return _sharedPreference.setString(Preferences.user, jsonEncode(user));
  }

  Future<bool> removeUser() async {
    return _sharedPreference.remove(Preferences.user);
  }

  // Login
  bool get isLoggedIn =>
      _sharedPreference.getBool(Preferences.isLoggedin) ?? false;

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.isLoggedin, value);
  }

  // Theme
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.isDarkMode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.isDarkMode, value);
  }

  // Language
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage) ?? "en";
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.currentLanguage, language);
  }
}
