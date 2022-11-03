import 'package:dio/dio.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/models/auth/forgot_password.dart';
import 'package:leagx/models/user/user.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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
  static Future<bool> subscribeOneLeague(int userId) async {
    Map<String,dynamic> body = {
      "user_id": userId,
      "plan_id": 1,
      "league": {
        "title": "King's Cup",
        "logo": "",
        "external_league_id": "604"
      }
    };
    bool success = await ApiService.postWoResponce(
      url: AppUrl.subscribeLeague,
      body: body);
    return success;
  }

    static Future<User?>? twitterLogin({
    required AuthType authType,
    required twitter.User user
  }) async {
    Loader.showLoader();
    int userId = user.id;
    dynamic responce = await ApiService.callPostApi(
      url: AppUrl.socialLogin,
      parameters: {
        "user[email]": "$userId@twitter.com",
        "user[first_name]": user.name,
        "user[uid]": userId,
        "user[provider]": authType.name
      },
      modelName: ApiModels.user,
    );
    Loader.hideLoader();
    return responce;
  }

    static Future<User?>? appleLogin(
      {required AuthType authType, required AuthorizationCredentialAppleID userCredentials}) async {
        dynamic responce;
        Loader.showLoader();
      if(userCredentials.email != null && userCredentials.givenName != null) {
        responce = await ApiService.callPostApi(
        url: AppUrl.socialLogin,
        parameters: {
          "user[email]": userCredentials.email,
          "user[first_name]": userCredentials.givenName,
          "user[uid]": userCredentials.userIdentifier,
          "user[provider]": authType.name
        },
        modelName: ApiModels.user,
      );
      } else {
        responce = await ApiService.callPostApi(
        url: AppUrl.socialLogin,
        parameters: {
          "user[uid]": userCredentials.userIdentifier,
          "user[provider]": authType.name
        },
        modelName: ApiModels.user,
      );
    }
    Loader.hideLoader();
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

  static Future<bool> changePassword({
    required String password,
  }) async {
    User? user = preferenceHelper.getUser();
    if(user != null) {
      String completeUrl = AppUrl.getUser + user.id.toString();
      FormData formData = FormData.fromMap({
        "user[password]": password,
        "user[password_confirmation]": password
      });
      User? userData =  await ApiService.callPutApi(
        url: completeUrl,
        body: formData,
        modelName: ApiModels.user,
      );
      if(userData != null) {
          preferenceHelper.saveAuthToken(userData.apiToken);
          preferenceHelper.saveUser(userData);
          ToastMessage.show(
              loc.authResetPasswordSuccessfull, TOAST_TYPE.success);
        return true;
      }
      return false;
    } else {
      ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
      return false;
    }
  }
}
