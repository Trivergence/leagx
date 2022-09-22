import 'package:leagx/models/choose_plan_args.dart';
import 'package:leagx/models/match_args.dart';
import 'package:leagx/ui/screens/admin/admin_announce.dart';
import 'package:leagx/ui/screens/admin/admin_fixture.dart';
import 'package:leagx/ui/screens/admin/admin_fixture_detail/admin_fixture_detail.dart';
import 'package:leagx/ui/screens/admin/admin_home.dart';
import 'package:leagx/ui/screens/authentication/forgot_password.dart';
import 'package:leagx/ui/screens/authentication/reset_password.dart';
import 'package:leagx/ui/screens/authentication/signin.dart';
import 'package:leagx/ui/screens/authentication/signup.dart';
import 'package:leagx/ui/screens/choose_an_expert/choose_an_expert.dart';
import 'package:leagx/ui/screens/choose_league/choose_league_screen.dart';
import 'package:leagx/ui/screens/choose_plan/edit_choose_plan.dart';
import 'package:leagx/ui/screens/dashboard/components/home/home.dart';
import 'package:leagx/ui/screens/dashboard/components/setting/components/choose_language.dart';
import 'package:leagx/ui/screens/dashboard/components/setting/setting.dart';
import 'package:leagx/ui/screens/dashboard/dashbard.dart';
import 'package:leagx/ui/screens/faq/faqs_screen.dart';
import 'package:leagx/ui/screens/notification/notification.dart';
import 'package:leagx/ui/screens/onboarding/onboarding_screen.dart';
import 'package:leagx/ui/screens/prediciton_s/prediction_s_screen.dart';
import 'package:leagx/ui/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:leagx/ui/screens/profile/profile_info_update.dart';
import 'package:leagx/ui/screens/profile/profile_settings.dart';
import 'package:leagx/ui/screens/terms_service/terms_service_screen.dart';
import 'package:leagx/ui/screens/upcoming_matches.dart';
import 'package:leagx/ui/screens/user/user.dart';
import 'package:flutter/material.dart';

import '../ui/screens/choose_plan/choose_plan_screen.dart';
import '../ui/screens/dashboard/components/news/add_news.dart';
import '../ui/screens/fixtureDetails/fixture_details_screen.dart';

class Routes {
  Routes();
  static const String signin = '/signin';
  static const String dashboard = '/dashboard';
  static const String onboarding = '/onboarding';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String termsService = '/termsService';
  static const String faqs = '/faqs';
  static const String fixtureDetails = '/fixtureDetails';
  static const String adminFixture = '/adminFixture';
  static const String adminFixtureDetail = '/adminFixtureDetail';
  static const String adminAnnounce = '/adminAnnounce';
  static const String chooseLeague = '/chooseLeague';
  static const String choosePlan = '/choosePlan';
  static const String home = '/home';
  static const String predictions = '/predicitons';
  static const String setting = '/setting';
  static const String profileSettings = '/profileSettings';
  static const String profileInfoUpdate = '/profileInfoUpdate';
  static const String admin = "/admin";
  static const String privacyPolicy = "/privacyPolicy";
  static const String user = "/user";
  static const String notification = "/notification";
  static const String chooseAnExpert = "/chooseAnExpert";
  static const String addNews = "/addNews";
  static const String editChoosePlan = "/editChoosePlan";
  static const String chooseLanguage = "/chooseLanguage";
  static const String upcomingMatches = "/upcomingMatches";

  Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onboarding:
        return generateRoute(routeSettings.name!, OnBoardingScreen());
      case signup:
        return generateRoute(routeSettings.name!, SignupScreen());
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
      case fixtureDetails:
        return generateRoute(routeSettings.name!, FixtureDetails(matchData: routeSettings.arguments as MatchArgs,));
      case adminFixture:
        return generateRoute(routeSettings.name!, const AdminFixtureScreen());
      case adminFixtureDetail:
        return generateRoute(routeSettings.name!, AdminFixtureDetailScreen());
      case adminAnnounce:
        return generateRoute(routeSettings.name!, AdmiinAnnounceScreen());
      case chooseLeague:
        return generateRoute(routeSettings.name!, ChooseLeagueScreen());
      case choosePlan:
        return generateRoute(
          routeSettings.name!,
          ChoosePlanScreen(
            leagueData: routeSettings.arguments as ChoosePlanArgs,
          ),
        );
      case home:
        return generateRoute(routeSettings.name!, HomeScreen());
      case predictions:
        return generateRoute(routeSettings.name!, const PredicitonsScreen());
      case dashboard:
        return generateRoute(routeSettings.name!, DashBoardScreen());
      case setting:
        return generateRoute(routeSettings.name!, SettingScreen());
      case profileSettings:
        return generateRoute(
            routeSettings.name!, const ProfileSettingsScreen());
      case profileInfoUpdate:
        return generateRoute(routeSettings.name!, ProfileInfoUpdateScreen());
      case admin:
        return generateRoute(routeSettings.name!, AdminHomeScreen());
      case privacyPolicy:
        return generateRoute(routeSettings.name!, const PrivacyPolicyScreen());
      case user:
        return generateRoute(routeSettings.name!, UserScreen());
      case notification:
        return generateRoute(routeSettings.name!, NotificationScreen());
      case chooseAnExpert:
        return generateRoute(routeSettings.name!, ChooseAnExpertScreen());
      case addNews:
        return generateRoute(routeSettings.name!, AddNewsScreen());
      case editChoosePlan:
        return generateRoute(routeSettings.name!, EditChoosePlanScreen());
      case chooseLanguage:
        return generateRoute(routeSettings.name!, ChooseLanguageScreen());
      case upcomingMatches:
        return generateRoute(routeSettings.name!, UpcomingMatches());   

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
