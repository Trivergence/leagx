import 'package:dio/dio.dart';
import 'package:leagx/core/network/app_url.dart';

import '../../../core/sharedpref/sharedpref.dart';

class TranslationUtility {
  static Future<String> translate(String text) async {
    String value = text;
    if (preferenceHelper.currentLanguage == "ar" && text.isNotEmpty) {
      var body = {"q": text};
      Map<String, dynamic> header = {'Content-Type': 'application/json'};
      try {
        Dio dio = Dio();
        Response response = await dio.post(AppUrl.translationUrl,
            options: Options(
              headers: header,
              responseType: ResponseType.plain,
            ),
            data: body);
        if (response.statusCode == 200) {
          value = response.data;
        }
      } on DioError catch (_) {
        return value;
      } on Exception catch (_) {
        return value;
      }
    }
    return value;
  }
}
