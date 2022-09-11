import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/models/error_model.dart';

class ApiService {
  
  static Future<dynamic> callPostApi({
    required String url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    dynamic modelName,
  }) async {
    try {
      BaseOptions options = BaseOptions(
        contentType: 'application/json',
        baseUrl: AppUrl.baseUrl,
        // headers: {},
      );
      
      var dio = Dio(options);
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Response _response = await dio.post(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
          
        );
        if(_response.statusCode==200 || _response.statusCode==201){
          dynamic modelObj = await ApiModels.getModelObjects(modelName, _response);
          return modelObj;
        }
      }else {
        print('no internet');
        return null;
      }
    } on DioError catch (ex){
      if(ex.response!=null){
        ErrorModel errorResponse = ApiModels.getModelObjects(ApiModels.error, ex.response);
        print(errorResponse.error);
        return null;
      }
    }on Exception {
      print('Strings.badhappenederror');
      return null;
    }
  }
}
