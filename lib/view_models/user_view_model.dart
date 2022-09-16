import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/models/user/userdata.dart';

class UserViewModel {
  static Future<UserData>? getUserData(int id) async {
    String completeUrl = AppUrl.getUser + "$id";
    return await ApiService.callGetApi(
      url: completeUrl,
      modelName: ApiModels.userData,
    );
  }
}
