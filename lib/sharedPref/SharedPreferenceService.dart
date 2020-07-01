import 'package:enum_to_string/enum_to_string.dart';
import 'package:noticetracker/enumerate/SharedPrefEnum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {

  static Future<int> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(EnumToString.parse(SharedPrefEnum.id));
  }

  static Future setId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(EnumToString.parse(SharedPrefEnum.id), id);
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EnumToString.parse(SharedPrefEnum.username));
  }

  static Future setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumToString.parse(SharedPrefEnum.username), username);
  }

  static Future setUsernamePassword(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumToString.parse(SharedPrefEnum.username), username);
    prefs.setString(EnumToString.parse(SharedPrefEnum.password), password);
  }

  static Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EnumToString.parse(SharedPrefEnum.password));
  }

  static Future setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumToString.parse(SharedPrefEnum.password), password);
  }

  static Future setAdmin(bool admin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(EnumToString.parse(SharedPrefEnum.admin), admin);
  }

  static Future<bool> isAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(EnumToString.parse(SharedPrefEnum.admin));
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EnumToString.parse(SharedPrefEnum.token));
  }

  static Future setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumToString.parse(SharedPrefEnum.token), token);
  }

  static logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(EnumToString.parse(SharedPrefEnum.username));
    prefs.remove(EnumToString.parse(SharedPrefEnum.password));
    prefs.remove(EnumToString.parse(SharedPrefEnum.token));
    prefs.remove(EnumToString.parse(SharedPrefEnum.id));
  }

}
