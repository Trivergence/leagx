import 'dart:async';
import 'constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  // Token
  String? get authToken => _sharedPreference.getString(Preferences.authToken);

  Future<bool> saveAuthToken(String authToken) async {
    return await _sharedPreference.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.authToken);
  }

  //Username
  String? get username => _sharedPreference.getString(Preferences.username);

  Future<bool> saveUsername(String username) async {
    return _sharedPreference.setString(Preferences.username, username);
  }

  Future<bool> removeUsername() async {
    return _sharedPreference.remove(Preferences.username);
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
    return _sharedPreference.getString(Preferences.currentLanguage);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.currentLanguage, language);
  }
}
