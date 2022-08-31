import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localization {
  static AppLocalizations? _loc;

  AppLocalizations get instance => Localization._loc!;
  static void init(BuildContext context) =>
      _loc = AppLocalizations.of(context)!;
}

AppLocalizations get loc => Localization().instance;