import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/models/auth/login.dart';
import 'package:leagx/models/auth/signup.dart';

class AuthViewModel {
  static Future<Signup> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await ApiService.callPostApi(
      url: AppUrl.signup,
      parameters: {
        "user[first_name]": name,
        "user[email]": email,
        "user[password]": password,
        "user[password_confirmation]": confirmPassword,
      },
      modelName: ApiModels.signup,
    );
  }

  static Future<Login> login({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await ApiService.callPostApi(
      url: AppUrl.login,
      parameters: {
        "email": email,
        "password": password,
      },
      modelName: ApiModels.login,
    );
  }
}
