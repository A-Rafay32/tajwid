import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajwid/app/constants/prefs_keys.dart';

class UserPrefs {
  static SharedPreferences? _pref;
  static Future init() async => _pref = await SharedPreferences.getInstance();

  /////////////////////////////////[ User ]///////////////////////////////////////////////////////////////////////

  static Future setUserSession(bool value) async {
    try {
      await _pref
          ?.setBool(PrefKeys.userSessionKey, value)
          .catchError((error) => throw error);
      print("user session cached successfully");
    } catch (e) {
      return e;
    }
  }

  static Future<bool?> getUserSession() async {
    bool? value = _pref?.getBool(PrefKeys.userSessionKey);
    return value;
  }

  static Future setUserInfo(String value) async {
    try {
      await _pref
          ?.setString(PrefKeys.userKey, value)
          .catchError((error) => throw error);
    } catch (e) {
      return e;
    }
  }

  static Future<String?> getUserInfo(String value) async {
    String? value = _pref?.getString(PrefKeys.userKey);
    return value;
  }

  static Future setToken(String value) async {
    try {
      await _pref
          ?.setString(PrefKeys.token, value)
          .catchError((error) => throw error);
    } catch (e) {
      return e;
    }
  }

  static Future<String> getToken() async {
    String? value = _pref?.getString(PrefKeys.token);
    return value ?? "";
  }

  static Future<void> delToken() async {
    await _pref?.remove(PrefKeys.token);
  }

  /////////////////////////////////[ List ]///////////////////////////////////////////////////////////////////////

  static Future setList(List<String> list) async {
    await _pref?.setStringList(PrefKeys.listKey, list);
  }

  static List<String>? getList() {
    return _pref?.getStringList(PrefKeys.listKey);
  }

  static Future deleteList() async {
    await _pref?.remove(PrefKeys.listKey);
  }

  static Future deleteItemFromList(String word) async {
    List<String> temp = _pref?.getStringList(PrefKeys.listKey) as List<String>;
    temp.remove(word);
    await _pref?.setStringList(PrefKeys.listKey, temp);
  }

  static Future setBool(String key, bool value) async {
    try {
      await _pref?.setBool(key, value).catchError((error) => throw error);
    } catch (e) {
      return e;
    }
  }

  static Future<bool?> getBool(String key) async {
    bool? value = _pref?.getBool(key);
    return value;
  }
}
