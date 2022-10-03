import 'package:dio/dio.dart';
import 'package:leagx/ui/util/toast/toast.dart';

import '../../../ui/util/locale/localization.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = loc.errorRequestCancelled;
        showToast(message);
        break;
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
        message = loc.errorConnectionTimeout;
        showToast(message);
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        showToast(message);
        break;
      case DioErrorType.sendTimeout:
        message = loc.errorSendTimeout;
        showToast(message);
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = loc.errorCheckNetwork;
          showToast(message);
          break;
        }
        message = loc.errorUndefined;
        showToast(message);
        break;
      default:
        message = loc.somethingWentWrong;
        showToast(message);
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return loc.errorRequestBad;
      case 401:
        return loc.errorRequestUnauthorized;
      case 403:
        return loc.errorRequestForbidden;
      case 404:
        return error['message'];
      case 500:
        return loc.errorInternalServer;
      case 502:
        return loc.errorBadGateway;
      default:
        return loc.somethingWentWrong;
    }
  }

  @override
  String toString() => message;

  void showToast(String message) {
    ToastMessage.show(message, TOAST_TYPE.error);
  }
}
