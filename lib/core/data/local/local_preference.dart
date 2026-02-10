import 'dart:convert';

import 'package:intranet/core/data/local/preferences.dart';
import 'package:intranet/core/data/local/shared_preferences_helper.dart';

class LocalPreference {
  SharedPreferenceHelper prefs;

  LocalPreference(this.prefs);

  Future<bool> getIsFirstOpen() {
    return prefs.getBool(Preferences.isFirstOpen);
  }

  Future setIsFirstOpen(bool value) async {
    return prefs.setBool(Preferences.isFirstOpen, value);
  }

  Future<String?> getAccessToken() async {
    return prefs.getString(Preferences.accessToken);
  }

  Future<void> setAccessToken(String token) async {
    return prefs.setString(Preferences.accessToken, token);
  }

  Future<String?> getRole() async {
    return prefs.getString(Preferences.userRole);
  }

  Future<void> setRole(String role) async {
    return prefs.setString(Preferences.userRole, role);
  }

  Future<bool> clearPreferences() async {
    return prefs.sharedPreferences.clear();
  }

}
