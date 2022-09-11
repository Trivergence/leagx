import 'package:leagx/models/auth/Login.dart';
import 'package:leagx/models/auth/signup.dart';
import 'package:leagx/models/error_model.dart';

class ApiModels {
  static const String error = 'Error';
  static const String login = 'LOGIN';
  static const String signup = 'SIGNUP';
  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      case error:
        return ErrorModel.fromJson(json);
      case login:
        return Login.fromJson(json);
      case signup:
        return Signup.fromJson(json);
    }
  }
}
