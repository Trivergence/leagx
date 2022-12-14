import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leagx/constants/app_constants.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/dio_exceptions.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/models/error_model.dart';
import 'package:leagx/service/hive_service.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../constants/enums.dart';
import '../../../ui/util/locale/localization.dart';

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
            "apitoken": preferenceHelper.authToken,
          },
          connectTimeout: AppConstants.networkTimeout,
          receiveTimeout: AppConstants.networkTimeout,
          sendTimeout: AppConstants.networkTimeout);

      var dio = Dio(options);
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
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            errorResponse.error ?? loc.errorUndefined, TOAST_TYPE.error);
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

  static Future<dynamic> callGetApi(
      {required String url,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? headers,
      dynamic modelName,
      bool cache = false,
      String? cacheBoxName,
      bool showToast = true,
      String baseUrl = AppUrl.baseUrl,
      RequestType requestType = RequestType.selfHostedApi}) async {
    try {
      BaseOptions options = BaseOptions(
          contentType: 'application/json',
          baseUrl: baseUrl,
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          connectTimeout: AppConstants.networkTimeout,
          receiveTimeout: AppConstants.networkTimeout,
          sendTimeout: AppConstants.networkTimeout);

      var dio = Dio(options);
      Response _response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: parameters,
      );
      debugPrint('get response: ${_response.data}');
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        dynamic modelObj =
            await ApiModels.getModelObjects(modelName, _response.data);
        if (cache == true) {
          await HiveService.addBoxes(_response.data, cacheBoxName!);
        }
        return modelObj;
      } else {
        if (cache == true) {
          return await getCachedObject(cacheBoxName, modelName);
        }
      }
    } on DioError catch (ex) {
      if (cache == true) {
        return await getCachedObject(cacheBoxName, modelName);
      }
      Loader.hideLoader();
      if (ex.response != null) {
        if (requestType == RequestType.selfHostedApi) {
          ErrorModel errorResponse =
              ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
          if (cache == false && showToast == true) {
            ToastMessage.show(
                errorResponse.error ?? loc.errorUndefined, TOAST_TYPE.error);
          }
        } else {
          return null;
        }
      } else {
        if (cache == false && showToast == true) {
          DioExceptions.fromDioError(ex);
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (cache == false && showToast == true) {
        ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
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
            "apitoken": preferenceHelper.authToken,
          },
          connectTimeout: AppConstants.networkTimeout,
          receiveTimeout: AppConstants.networkTimeout,
          sendTimeout: AppConstants.networkTimeout);

      var dio = Dio(options);
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
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            errorResponse.error ?? loc.errorUndefined, TOAST_TYPE.error);
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
            "apitoken": preferenceHelper.authToken,
          },
          connectTimeout: AppConstants.networkTimeout,
          receiveTimeout: AppConstants.networkTimeout,
          sendTimeout: AppConstants.networkTimeout);

      var dio = Dio(options);
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
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            errorResponse.error ?? loc.errorUndefined, TOAST_TYPE.error);
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
    bool cache = false,
    String? cacheBoxName,
    bool showToast = true,
    RequestType requestType = RequestType.selfHostedApi,
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
          sendTimeout: AppConstants.networkTimeout);
      var dio = Dio(options);
      //dio.interceptors.add(PrettyDioLogger());
      Response _response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: parameters,
      );
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        if (_response.data is List<dynamic>) {
          String encodedString = jsonEncode(_response.data);
          dynamic listOfData =
              ApiModels.getListOfObjects(modelName, encodedString);
          if (cache == true) {
            await HiveService.addBoxes(encodedString, cacheBoxName!);
          }
          return listOfData;
        } else {
          if (cache == true) {
            return await getCachedList(cacheBoxName, modelName);
          }
        }
      }
      return [];
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (cache == true) {
        return await getCachedList(cacheBoxName, modelName);
      }
      if (ex.response != null) {
        if (requestType == RequestType.footballApi) {
          if (cache == false && showToast == true) {
            ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
          }
        } else {
          ErrorModel errorResponse =
              ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
          if (cache == false && showToast == true) {
            ToastMessage.show(
                errorResponse.error ?? loc.errorUndefined, TOAST_TYPE.error);
          }
        }
        return [];
      } else {
        if (cache == false && showToast == true) {
          DioExceptions.fromDioError(ex);
        }
        return [];
      }
    }
    // catch (e) {
    //   debugPrint(e.toString());
    //   if (cache == false && showToast == true) {
    //     ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
    //   } else {
    //     return await getCachedList(cacheBoxName, modelName);
    //   }
    //   Loader.hideLoader();
    //   return [];
    // }
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
          sendTimeout: AppConstants.networkTimeout);

      var dio = Dio(options);
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
      return null;
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ToastMessage.show(loc.errorUndefined, TOAST_TYPE.error);
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

  static Future<List<dynamic>> getCachedList(
      String? cacheBoxName, modelName) async {
    bool isExist = await HiveService.isExists(boxName: cacheBoxName!);
    if (isExist == true) {
      dynamic cachedResponce = await HiveService.getBoxes(cacheBoxName);
      //String encodedString = jsonEncode(cachedResponce);
      dynamic listOfData =
          ApiModels.getListOfObjects(modelName, cachedResponce);
      return listOfData;
    }
    return [];
  }

  static Future<dynamic> getCachedObject(
      String? cacheBoxName, modelName) async {
    bool isExist = await HiveService.isExists(boxName: cacheBoxName!);
    if (isExist == true) {
      dynamic cachedResponce = await HiveService.getBoxes(cacheBoxName);
      dynamic listOfData = ApiModels.getModelObjects(
          modelName, Map<String, dynamic>.from(cachedResponce));
      return listOfData;
    }
  }
}
