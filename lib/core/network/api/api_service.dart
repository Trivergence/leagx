import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/models/error_model.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/toast/toast.dart';

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
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected) {
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
            ToastMessage.show("${errorResponse.error} ${errorResponse.errorLog??''}",TOAST_TYPE.error );
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened,TOAST_TYPE.error );
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
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected) {
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
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected) {
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
            ToastMessage.show("${errorResponse.error} ${errorResponse.errorLog??''}",TOAST_TYPE.error );
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened,TOAST_TYPE.error );
      return null;
    } catch(e){
      debugPrint(e.toString());
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
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected) {
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
            ToastMessage.show("${errorResponse.error} ${errorResponse.errorLog??''}",TOAST_TYPE.error );
        return null;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened,TOAST_TYPE.error );
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
      );
      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected) {
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
        ErrorModel errorResponse =
            ApiModels.getModelObjects(ApiModels.error, ex.response?.data);
        ToastMessage.show(
            "${errorResponse.error} ${errorResponse.errorLog ?? ''}",
            TOAST_TYPE.error);
        return [];
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      ToastMessage.show(Strings.badHappened, TOAST_TYPE.error);
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
      );

      var dio = Dio(options);
      bool isConnected = await InternetInfo.isConnected();
      if (isConnected) {
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
            "${errorResponse.error} ${errorResponse.errorLog ?? ''}",
            TOAST_TYPE.error);
        return false;
      }
    } on Exception {
      Loader.hideLoader();
      ToastMessage.show(Strings.badHappened, TOAST_TYPE.error);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      Loader.hideLoader();
      return false;
    }
    return false;
  }
}

