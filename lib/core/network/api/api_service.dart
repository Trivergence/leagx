import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leagx/constants/app_constants.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/dio_exceptions.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/models/error_model.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../constants/enums.dart';
import '../../../ui/util/locale/localization.dart';
import '../internet_info.dart';

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
        headers: {
          "apitoken":preferenceHelper.authToken,
        },
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
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
          return modelObj;
        }
      } 
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
            ToastMessage.show(errorResponse.error ?? loc.errorUndefined,TOAST_TYPE.error );
        return null;
      } else {
        DioExceptions.fromDioError(ex);
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(loc.errorUndefined,TOAST_TYPE.error );
      return null;
    } catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
      Loader.hideLoader();
      return null;
    }
  }
  static Future<dynamic> callGetApi({
    required String url,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    dynamic modelName,
    String baseUrl = AppUrl.baseUrl,
    RequestType requestType = RequestType.selfHostedApi
  }) async {
    try {
      BaseOptions options = BaseOptions(
        contentType: 'application/json',
        baseUrl: baseUrl,
        headers: {
          "apitoken": preferenceHelper.authToken,
        },
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
        Response _response = await dio.get(
          url,
          options: Options(headers: headers),
          queryParameters: parameters,
        );
        debugPrint('get response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      }
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        if(requestType == RequestType.selfHostedApi) {
          ErrorModel errorResponse =
          ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
          ToastMessage.show(
              errorResponse.error ?? loc.errorUndefined, TOAST_TYPE.error);
              return null;
        } else {
          return null;
        }
      } else {
        DioExceptions.fromDioError(ex);
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(loc.errorUndefined,TOAST_TYPE.error );
      return null;
    } catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
      Loader.hideLoader();
      return null;
    }
  }
  static Future<dynamic> callPutApi({
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
        headers: {
          "apitoken":preferenceHelper.authToken,
        },
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
        Response _response = await dio.put(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
        debugPrint('put response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      }
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
            ToastMessage.show(errorResponse.error ?? loc.errorUndefined,TOAST_TYPE.error );
        return null;
      } else {
        DioExceptions.fromDioError(ex);
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(loc.errorUndefined,TOAST_TYPE.error );
      return null;
    } catch(e){
      debugPrint(e.toString());
      Loader.hideLoader();
      return null;
    }
  } 

  static Future<bool> callPutApiWoResponce({
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
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          connectTimeout: AppConstants.networkTimeout,
          receiveTimeout: AppConstants.networkTimeout,
          sendTimeout: AppConstants.networkTimeout);

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
        Response _response = await dio.put(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
        debugPrint('put response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          return true;
        }
      }
      return false;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            errorResponse.error ?? loc.errorUndefined, TOAST_TYPE.error);
        return false;
      } else {
        DioExceptions.fromDioError(ex);
        return false;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      Loader.hideLoader();
      return false;
    }
  }

  static Future<dynamic> callDeleteApi({
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
        headers: {
          "apitoken":preferenceHelper.authToken,
        },
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
        Response _response = await dio.delete(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
        debugPrint('delete response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      } 
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
            ToastMessage.show(errorResponse.error ?? loc.errorUndefined,TOAST_TYPE.error );
        return null;
      } else {
        DioExceptions.fromDioError(ex);
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(loc.errorUndefined,TOAST_TYPE.error );
      return null;
    } catch(e){
      debugPrint(e.toString());
      Loader.hideLoader();
      return null;
    }
  }

  static Future<List<dynamic>> getListRequest({
    required String baseUrl,
    String url = "",
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    required dynamic modelName,
  }) async {
    try {
      BaseOptions options = BaseOptions(
        contentType: 'application/json',
        baseUrl: baseUrl,
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout
      );
      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
        Response _response = await dio.get(
          url,
          options: Options(headers: headers),
          queryParameters: parameters,
        );
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          if(_response.data is List<dynamic>)  {
            dynamic listOfData = ApiModels.getListOfObjects(
            modelName, jsonEncode(_response.data));
            return listOfData;
          } else {
            return [];
          }
          
        }
      }
      return [];
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        if(baseUrl == AppUrl.footballBaseUrl) {
          ToastMessage.show(
            loc.errorUndefined,
            TOAST_TYPE.error);
        } else {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            errorResponse.error ?? loc.errorUndefined,
            TOAST_TYPE.error);
        }
        return [];
      } else {
        DioExceptions.fromDioError(ex);
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
      Loader.hideLoader();
      return [];
    }
  }
  static Future<bool> postWoResponce({
    required String url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      BaseOptions options = BaseOptions(
        contentType: 'application/json',
        baseUrl: AppUrl.baseUrl,
        headers: {
          "apitoken": preferenceHelper.authToken,
        },
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
        Response _response = await dio.post(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
        debugPrint('post response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          return true;
        }
      } 
      return false;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            errorResponse.error ?? loc.errorUndefined,
            TOAST_TYPE.error);
        return false;
      } else {
        DioExceptions.fromDioError(ex);
        return false;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      Loader.hideLoader();
      return false;
    }
  }

  static Future<dynamic> callCurrencyConverter({
    required String url,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    dynamic modelName,
  }) async {
    try {
      BaseOptions options = BaseOptions(
          contentType: 'application/json',
          baseUrl: AppUrl.currencyBaseUrl,
          headers: {
            "X-RapidAPI-Key": AppConstants.currencyApiKey,
            "X-RapidAPI-Host": "currency-converter5.p.rapidapi.com"
          },
          connectTimeout: AppConstants.networkTimeout,
          receiveTimeout: AppConstants.networkTimeout,
          sendTimeout: AppConstants.networkTimeout);

      var dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger());
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected == true) {
        Response _response = await dio.get(
          url,
          options: Options(headers: headers),
          queryParameters: parameters,
        );
        debugPrint('get response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      }
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ToastMessage.show(
            loc.errorUndefined, TOAST_TYPE.error);
        return null;
      } else {
        DioExceptions.fromDioError(ex);
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Loader.hideLoader();
      return null;
    }
  }
}

