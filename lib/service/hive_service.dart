import 'package:hive/hive.dart';
import 'package:leagx/constants/app_constants.dart';

class HiveService {
  static Future<bool> isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  static Future<void> addBoxes(dynamic responceString, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.put(AppConstants.hiveKey, responceString);
  }

  static Future<dynamic> getBoxes(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.get(AppConstants.hiveKey);
  }
}
