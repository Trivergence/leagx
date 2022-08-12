import 'package:bailbooks_defendant/ui/screens/authentication/forgot_password.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/reset_password.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/signin.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/signup.dart';
import 'package:bailbooks_defendant/ui/screens/choose_league/choose_league_screen.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/home/home.dart';
import 'package:bailbooks_defendant/ui/screens/faq/faqs_screen.dart';
import 'package:bailbooks_defendant/ui/screens/onboarding/onboarding_screen.dart';
import 'package:bailbooks_defendant/ui/screens/prediciton_s/prediction_s_screen.dart';
import 'package:bailbooks_defendant/ui/screens/terms_service/terms_service_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/fixtureDetails/fixture_details_screen.dart';

class Routes {
  Routes();
  static const String signin = '/signin';
  static const String dashboard = '/dashboard';
  static const String onboarding='/onboarding';
  static const String signup ='/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword ='/resetPassword';
  static const String termsService = '/termsService';
  static const String faqs= '/faqs';
  static const String matchDetails = '/matchDetails';
  static const String chooseLeague = '/chooseLeague';
  static const String choosePlan= '/choosePlan';
  static const String home = '/home';
  static const String predictions = '/predicitons';

  Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onboarding:
        return generateRoute(routeSettings.name!, OnBoardingScreen());
      case signup:
        return generateRoute(routeSettings.name!,  SignupScreen());
      case signin:
        return generateRoute(routeSettings.name!, SigninScreen());
      case forgotPassword:
        return generateRoute(routeSettings.name!, ForgotPasswordScreen());
      case resetPassword:
        return generateRoute(routeSettings.name!, ResetPasswordScreen());
      case termsService:
        return generateRoute(routeSettings.name!, const TermsServiceScreen());
      case faqs:
        return generateRoute(routeSettings.name!, const FaqsScreen());
      case matchDetails:
        return generateRoute(routeSettings.name!, const FixtureDetails());
      case chooseLeague:
        return generateRoute(routeSettings.name!, ChooseLeagueScreen());
        case choosePlan:
        return generateRoute(routeSettings.name!, ChooseLeagueScreen());
      case home:
        return generateRoute(routeSettings.name!, const HomeScreen());  
      case predictions:
      return generateRoute(routeSettings.name!, const PredicitonsScreen());  


      default:
        return generateRoute(
          routeSettings.name!,
          Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }

  MaterialPageRoute generateRoute(String routeName, Widget widget) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => widget,
    );
  }

  PageRouteBuilder generatePopupRoute(String routeName, Widget widget) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
