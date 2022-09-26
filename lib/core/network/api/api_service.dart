// ignore_for_file: unused_import

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:leagx/constants/app_constants.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/error_model.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../models/dashboard/league.dart';
import '../../../models/dashboard/news.dart';
import '../../../models/leader.dart';
import '../../../models/players.dart';
import '../../../models/subscribed_league.dart';
import '../../../models/subscription_plan.dart';

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
        print('post response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      } else {
        ToastMessage.show(Strings.noInternet,TOAST_TYPE.error );
        return null;
      }
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
            ToastMessage.show("${errorResponse.error} ${errorResponse.errorLog??''}",TOAST_TYPE.error );
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened,TOAST_TYPE.error );
      return null;
    } catch(e){
      print(e.toString());
      Loader.hideLoader();
      return null;
    }
  }
  static Future<dynamic> callGetApi({
    required String url,
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
      );

      var dio = Dio(options);
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Response _response = await dio.get(
          url,
          options: Options(headers: headers),
          queryParameters: parameters,
        );
        print('get response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      } else {
        ToastMessage.show(Strings.noInternet,TOAST_TYPE.error );
        return null;
      }
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
            ToastMessage.show("${errorResponse.error} ${errorResponse.errorLog??''}",TOAST_TYPE.error );
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened,TOAST_TYPE.error );
      return null;
    } catch(e){
      print(e.toString());
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
      );

      var dio = Dio(options);
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Response _response = await dio.put(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
        print('put response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      } else {
        ToastMessage.show(Strings.noInternet,TOAST_TYPE.error );
        return null;
      }
    } on DioError catch (ex) {
      Loader.hideLoader();
      print('error response: ${ex.response}');
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
            ToastMessage.show("${errorResponse.error} ${errorResponse.errorLog??''}",TOAST_TYPE.error );
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened,TOAST_TYPE.error );
      return null;
    } catch(e){
      print(e.toString());
      Loader.hideLoader();
      return null;
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
      );

      var dio = Dio(options);
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Response _response = await dio.delete(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
        print('delete response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic modelObj =
              await ApiModels.getModelObjects(modelName, _response.data);
          return modelObj;
        }
      } else {
        ToastMessage.show(Strings.noInternet,TOAST_TYPE.error );
        return null;
      }
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
            ToastMessage.show("${errorResponse.error} ${errorResponse.errorLog??''}",TOAST_TYPE.error );
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened,TOAST_TYPE.error );
      return null;
    } catch(e){
      print(e.toString());
      Loader.hideLoader();
      return null;
    }
  }

  static Future<dynamic> getListRequest({
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
      );
      var dio = Dio(options);
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Response _response = await dio.get(
          url,
          options: Options(headers: headers),
          queryParameters: parameters,
        );
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          dynamic listOfData = ApiModels.getListOfObjects(modelName,
          jsonEncode(_response.data));
          return listOfData;
        }
      } else {
        ToastMessage.show(Strings.noInternet, TOAST_TYPE.error);
        return [];
      }
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            "${errorResponse.error} ${errorResponse.errorLog ?? ''}",
            TOAST_TYPE.error);
        return [];
      }
      return [];
    } 
    on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened, TOAST_TYPE.error);
      return [];
    } catch (e) {
      print(e.toString());
      Loader.hideLoader();
      return [];
    }
    return [];
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
      );

      var dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger());
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Response _response = await dio.post(
          url,
          options: Options(headers: headers),
          data: body,
          queryParameters: parameters,
        );
        print('post response: ${_response.data}');
        if (_response.statusCode == 200 || _response.statusCode == 201) {
          return true;
        }
      } else {
        ToastMessage.show(Strings.noInternet, TOAST_TYPE.error);
        return false;
      }
    } on DioError catch (ex) {
      Loader.hideLoader();
      if (ex.response != null) {
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            "${errorResponse.error} ${errorResponse.errorLog ?? ''}",
            TOAST_TYPE.error);
        return false;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened, TOAST_TYPE.error);
      return false;
    } catch (e) {
      print(e.toString());
      Loader.hideLoader();
      return false;
    }
    return false;
  }
}

