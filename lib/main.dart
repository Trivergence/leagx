import 'dart:async';

import 'package:bailbooks_defendant/core/network/config/environment.dart';
import 'package:bailbooks_defendant/ui/screens/betting.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    runApp(
      LayoutBuilder(
        builder: (context, constraints) => OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Betting(prefs: prefs);
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
