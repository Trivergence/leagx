import 'package:bailbooks_defendant/constants/app_theme.dart';
import 'package:bailbooks_defendant/constants/strings.dart';
import 'package:bailbooks_defendant/providers/session_provider.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/base_widget.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard.dart';
import 'package:bailbooks_defendant/ui/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bailbooks extends StatelessWidget {
  final SharedPreferences prefs;

  const Bailbooks({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: SessionProvider(prefs: prefs),
      child: const SizedBox(),
      onModelReady: (SessionProvider sessionProvider) => sessionProvider.init(),
      builder: (context, SessionProvider sessionProvider, __) {
        return MaterialApp(
          title: Strings.appName,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          debugShowCheckedModeBanner: false,
          theme: themeLight,
          onGenerateRoute: Routes().generateRoutes,
          home: Builder(
            builder: (context) {
              switch (sessionProvider.loginStatus) {
                case LoginStatus.none:
                case LoginStatus.loggingIn:
                case LoginStatus.error:
                  return const LoginScreen();
                case LoginStatus.loggedIn:
                  return const DashboardScreen();
              }
            },
          ),
        );
      },
    );
  }
}