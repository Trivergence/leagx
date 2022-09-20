import 'package:leagx/models/auth/forgot_password.dart';
import 'package:leagx/models/dashboard/events.dart';
import 'package:leagx/models/error_model.dart';
import 'package:leagx/models/user/user.dart';
import 'package:leagx/models/user/userdata.dart';

class ApiModels {
  static const String error = 'Error';
  static const String forgotPassword = "FORGOT_PASSWORD";
  static const String user = "USER";
  static const String upcomingMatches = "UPCOMING_MATCHES";
  static const String userData = "USERDATA";
  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      case error:
        return ErrorModel.fromJson(json);
      case forgotPassword:
        return ForgotPassword.fromJson(json);
      case user:
        return User.fromJson(json); 
      case userData:
        return UserData.fromJson(json);
      case upcomingMatches:
        return Events.fromJson(json);    
    }
  }
}
