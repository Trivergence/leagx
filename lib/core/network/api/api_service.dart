import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ApiService {
  static Future<dynamic> callPostApi({
    required String url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    dynamic modelName,
  }) async {
    try {
      var dio = Dio();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Response _response = await dio.post(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
      }
    } on Exception {}
  }
}
