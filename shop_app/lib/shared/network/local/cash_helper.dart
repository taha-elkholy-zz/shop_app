import 'package:shared_preferences/shared_preferences.dart';

// this class must be initialize before runApp method
class CashHelper {
  // late init sharedPreferences object
  static late SharedPreferences _preferences;

  // init method fore start the sharedPreferences object
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

// this method for set th boolean data to the shared preferences object
  static Future<bool> setBoolean(
      {required String key, required bool value}) async {
    return await _preferences.setBool(key, value);
  }

// this method for get the boolean data from the shared preferences object
  static bool? getBoolean({required String key}) {
    return _preferences.getBool(key);
  }
}
