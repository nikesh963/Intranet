import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences sharedPreferences;

  SharedPreferenceHelper(this.sharedPreferences);

  Future<bool> getBool(String key) async {
    return sharedPreferences.getBool(key) ?? false;
  }

  Future setBool(String key, bool value) async {
    return sharedPreferences.setBool(key, value);
  }

  Future<int> getInt(String key) async {
    return sharedPreferences.getInt(key) ?? 0;
  }

  Future setInt(String key, int value) async {
    return sharedPreferences.setInt(key, value);
  }

  Future<String> getString(String key) async {
    return sharedPreferences.getString(key) ?? '';
  }

  Future setString(String key, String value) async {
    return sharedPreferences.setString(key, value);
  }

  Future<double> getDouble(String key) async {
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  Future setDouble(String key, double value) async {
    return sharedPreferences.setDouble(key, value);
  }
}
