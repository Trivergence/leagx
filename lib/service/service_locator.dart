import 'package:get_it/get_it.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  //Shared Preferences
  locator.registerSingleton<SharedPreferences>((await SharedPreferences.getInstance()));

  locator.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(GetIt.I.get<SharedPreferences>()));
}