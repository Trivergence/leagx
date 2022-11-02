import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/sharedpref/sharedpref.dart';

class TranslationUtility {
  static Future<String> translate(String text) async {
    String value= text;
    if(preferenceHelper.currentLanguage == "ar" && text.isNotEmpty) {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('http://54.211.12.135:5000/api/translation'));
      request.body = jsonEncode({"q": value});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        text = await response.stream.bytesToString();
      }
    }
    return text;
  }
}