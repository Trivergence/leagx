import 'package:translator/translator.dart';

import '../../../core/sharedpref/sharedpref.dart';

class TranslationUtility {
  static Future<String> translate(String text) async {
    if(preferenceHelper.currentLanguage == "ar") {
      Translation translation = await GoogleTranslator().translate(text, from: "en", to: "ar");
      return translation.text;
    }
    return text;
  }
}