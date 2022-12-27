part of payments;

class ApiService {
  static Future<Result<ErrorModel, dynamic>> callPostApi({
    required String url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    dynamic modelName,
  }) async {
    try {
      BaseOptions options = BaseOptions(
          contentType: "application/x-www-form-urlencoded",
          baseUrl: PaymentUrl.baseUrl,
          headers: {
            "Authorization": "Bearer ${StripeConfig().getSecretKey}",
          },
          connectTimeout: PaymentConstants.networkTimeout,
          receiveTimeout: PaymentConstants.networkTimeout,
          sendTimeout: PaymentConstants.networkTimeout);

      var dio = Dio(options);
      // bool isConnected = await InternetInfo.isConnected();
      // if (isConnected == true) {
      Response _response = await dio.post(
        url,
        options: Options(headers: headers),
        data: body,
        queryParameters: parameters,
      );
      debugPrint('post response: ${_response.data}');
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        dynamic modelObj =
            await ApiModels.getModelObjects(modelName, _response.data);
        return Success(modelObj);
      }
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
      // }
      // return null;
    } on DioError catch (ex) {
      if (ex.response != null) {
        ErrorModel errorModel =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        return Error(errorModel);
      } else {
        return Error(ErrorModel(
            error:
                ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
      }
    } on Exception {
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
    }
  }

  static Future<Result<ErrorModel, bool>> callPostWoResponceApi({
    required String url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    dynamic modelName,
  }) async {
    try {
      BaseOptions options = BaseOptions(
          contentType: "application/x-www-form-urlencoded",
          baseUrl: PaymentUrl.baseUrl,
          headers: {
            "Authorization": "Bearer ${StripeConfig().getSecretKey}",
          },
          connectTimeout: PaymentConstants.networkTimeout,
          receiveTimeout: PaymentConstants.networkTimeout,
          sendTimeout: PaymentConstants.networkTimeout);

      var dio = Dio(options);
      // bool isConnected = await InternetInfo.isConnected();
      // if (isConnected == true) {
      Response _response = await dio.post(
        url,
        options: Options(headers: headers),
        data: body,
        queryParameters: parameters,
      );
      debugPrint('post response: ${_response.data}');
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        return const Success(true);
      }
      return const Success(false);
      // }
      // return null;
    } on DioError catch (ex) {
      //Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorModel =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        return Error(errorModel);
      } else {
        return Error(ErrorModel(
            error:
                ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
      }
    } on Exception {
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
    }
  }

  static Future<Result<ErrorModel, dynamic>> callGetApi({
    required String url,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    dynamic modelName,
  }) async {
    try {
      BaseOptions options = BaseOptions(
          contentType: 'application/x-www-form-urlencoded',
          baseUrl: PaymentUrl.baseUrl,
          headers: {
            "Authorization": "Bearer ${StripeConfig().getSecretKey}",
          },
          connectTimeout: PaymentConstants.networkTimeout,
          receiveTimeout: PaymentConstants.networkTimeout,
          sendTimeout: PaymentConstants.networkTimeout);

      var dio = Dio(options);
      // bool isConnected = await InternetInfo.isConnected();
      // if (isConnected == true) {
      Response _response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: parameters,
      );
      debugPrint('get response: ${_response.data}');
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        dynamic modelObj =
            await ApiModels.getModelObjects(modelName, _response.data);
        return Success(modelObj);
      }
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
      // }
      // return null;
    } on DioError catch (ex) {
      if (ex.response != null) {
        ErrorModel errorModel =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        return Error(errorModel);
      } else {
        return Error(ErrorModel(
            error:
                ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
      }
    } on Exception {
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(ErrorModel(
          error:
              ErrorData(code: PaymentConstants.somethingWentWrongErrorCode)));
    }
  }
}
