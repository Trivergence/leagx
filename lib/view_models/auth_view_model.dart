import 'package:leagx/constants/enums.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/models/auth/forgot_password.dart';
import 'package:leagx/models/auth/signin.dart';
import 'package:leagx/models/auth/signup.dart';
import 'package:leagx/models/user/user.dart';
import 'package:twitter_login/entity/user.dart' as twitter;

class AuthViewModel {
  static Future<User?>? signup({
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
      modelName: ApiModels.user,
    );
  }

  static Future<User?>? login({
    required String email,
    required String password,
  }) async {
    return await ApiService.callPostApi(
      url: AppUrl.login,
      parameters: {
        "email": email,
        "password": password,
      },
      modelName: ApiModels.user,
    );
  }

    static Future<User?>? socialLogin({
    required AuthType authType,
    required twitter.User user
  }) async {
    String userEmail = user.screenName;
    int userId = user.id;
    List<String> fullName = user.name.split(" ");
    String firstName;
    String lastName = '';
    if(fullName.length > 1) {
      firstName = fullName[0];
      lastName = fullName[1];
    } else {
      firstName = fullName[0];
    }
    //TODO: change email
    dynamic responce = await ApiService.callPostApi(
      url: AppUrl.socialLogin,
      parameters: {
        "user[email]": "test@gmail.com",
        "user[first_name]": firstName,
        "user[last_name]": lastName,
        "user[uid]": userId,
        "user[provider]": authType.name
      },
      modelName: ApiModels.user,
    );
    return responce;
  }

  static Future<ForgotPassword?>? forgotPassword({
    required String email,
  }) async {
    return await ApiService.callPutApi(
      url: AppUrl.forgotPassword,
      parameters: {
        "email": email,
      },
      modelName: ApiModels.forgotPassword,
    );
  }
}
