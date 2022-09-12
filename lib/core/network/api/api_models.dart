import 'package:leagx/models/auth/forgot_password.dart';
import 'package:leagx/models/auth/signin.dart';
import 'package:leagx/models/auth/signup.dart';
import 'package:leagx/models/error_model.dart';

class ApiModels {
  static const String error = 'Error';
  static const String signin = 'SIGNIN';
  static const String signup = 'SIGNUP';
  static const String forgotPassword = "FORGOT_PASSWORD";
  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      case error:
        return ErrorModel.fromJson(json);
      case signin:
        return Signin.fromJson(json);
      case signup:
        return Signup.fromJson(json);
      case forgotPassword:
        return ForgotPassword.fromJson(json);
    }
  }
}
