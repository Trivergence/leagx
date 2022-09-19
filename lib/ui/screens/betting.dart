import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leagx/constants/app_theme.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/providers/session_provider.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/authentication/signin.dart';
import 'package:leagx/ui/screens/base_widget.dart';
import 'package:leagx/ui/screens/dashboard/dashbard.dart';
import 'package:leagx/ui/screens/onboarding/onboarding_screen.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/gesture_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Betting extends StatelessWidget {
  final SharedPreferences prefs;
  late LocalizationProvider _localizationProvider;

  Betting({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureWidget(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Loader.hideLoader();
      },
      child: BaseWidget(
        model: SessionProvider(prefs: prefs),
        child: const SizedBox(),
        onModelReady: (SessionProvider sessionProvider) {
          FlutterNativeSplash.remove();
          sessionProvider.init();
          _localizationProvider = context.watch<LocalizationProvider>();
          _localizationProvider.init();
        },
        builder: (context, SessionProvider sessionProvider, __) {
          return MaterialApp(
            title: Strings.appName,
            locale: _localizationProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            debugShowCheckedModeBanner: false,
            theme: themeLight,
            onGenerateRoute: Routes().generateRoutes,
            builder: EasyLoading.init(),
            home: Builder(
              builder: (context) {
                switch (sessionProvider.loginStatus) {
                  case LoginStatus.none:
                    return OnBoardingScreen();
                  case LoginStatus.loggingIn:
                  case LoginStatus.error:
                    return SigninScreen();
                  case LoginStatus.loggedIn:
                    return DashBoardScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
