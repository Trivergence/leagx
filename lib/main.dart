import 'dart:async';

import 'package:leagx/core/network/config/environment.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/screens/betting.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    //
  };
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    loadAppEnvironment();
    await setPreferredOrientations();
    final prefs = await SharedPreferences.getInstance();
    await setupLocator();

    runApp(
      LayoutBuilder(
        builder: (context, constraints) => OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<LocalizationProvider>(create: (_) => LocalizationProvider(preferences: prefs)),
              ],
              child: Betting(prefs: prefs));
          },
        ),
      ),
    );
  }, (error, stack) async {
    //
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

void loadAppEnvironment() {
  Environment().initConfig(
    const String.fromEnvironment(
      'BUILD_ENV',
      defaultValue: Environment.dev,
    ),
  );
}
