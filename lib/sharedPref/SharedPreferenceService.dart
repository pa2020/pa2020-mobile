import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:noticetracker/enumerate/SharedPrefEnum.dart';
import 'package:noticetracker/request/Request.dart';
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

  static Future setRequests(List<Request> requests) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList=[];
    for(var i = 0; i<requests.length;i++){
      jsonList.add(jsonEncode(requests[i].toJson()));
    }
    String requestsStr=jsonEncode(jsonList);
    prefs.setString(EnumToString.parse(SharedPrefEnum.requests), requestsStr);
  }

  static Future<List<Request>> getRequests() async {
    List<Request> reqList =[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(EnumToString.parse(SharedPrefEnum.requests));
    if(json!=null) {
      var jsonList = jsonDecode(json) as List;
      for(int i = 0; i<jsonList.length;i++){
        reqList.add((Request.withJsonForAnalyzeReq(jsonDecode(jsonList[i]))));
      }
      return reqList;
    }
    return reqList;
  }

  static logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(EnumToString.parse(SharedPrefEnum.username));
    prefs.remove(EnumToString.parse(SharedPrefEnum.password));
    prefs.remove(EnumToString.parse(SharedPrefEnum.token));
    prefs.remove(EnumToString.parse(SharedPrefEnum.id));
    prefs.remove(EnumToString.parse(SharedPrefEnum.requests));
  }

  static Future<void> removeRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(EnumToString.parse(SharedPrefEnum.requests));
  }

}
