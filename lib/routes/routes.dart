import 'package:bailbooks_defendant/ui/screens/authentication/signup_screen.dart';
import 'package:bailbooks_defendant/ui/screens/login.dart';
import 'package:bailbooks_defendant/ui/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes();
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String onboarding='/onboarding';
  static const String signup ='/signup';

  Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case login:
        return generateRoute(routeSettings.name!, const LoginScreen());
      case onboarding:
        return generateRoute(routeSettings.name!, OnBoardingScreen());
      case signup:
        return generateRoute(routeSettings.name!, const SignupScreen()); 

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
