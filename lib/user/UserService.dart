import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:noticetracker/sharedPref/SharedPreferenceService.dart';
import 'package:noticetracker/signIn/LoginForm.dart';
import 'package:noticetracker/user/UserDto.dart';

import '../HomePage.dart';

class UserService {

  static Future<http.Response> _loginUserRequest(LoginForm login) async {
    return http.post("https://pa2020-api.herokuapp.com/api/v1/auth/signin",
        body: jsonEncode(<String, String>{
          "password": login.password,
          "username": login.username
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  static Future<http.Response> _registerUserRequest(UserDto userDto) async {
    String roles = listToString(userDto.role);
    return http.post("https://pa2020-api.herokuapp.com/api/v1/auth/signup",
        body: jsonEncode(<String, Object>{
          "email": userDto.email,
          "firstname": userDto.firstName,
          "lastname": userDto.lastName,
          "password": userDto.password,
          "role": [roles],
          "username": userDto.username
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  static Future<http.Response> _updateUserProfile(UserDto userDto) async {
    int id = await SharedPreferenceService.getId();
    String token = await SharedPreferenceService.getToken();
    return http.put("https://pa2020-api.herokuapp.com/api/v1/users/$id",
        body: jsonEncode(<String, Object>{
          "email": userDto.email,
          "firstName": userDto.firstName,
          "lastName": userDto.lastName
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + token,
        });
  }

  static Future<http.Response> getUserById(int id) async {
    String token = await SharedPreferenceService.getToken();
    return http.get("https://pa2020-api.herokuapp.com/api/v1/users/$id",
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-",
          "Authorization": "Bearer " + token,
        });
  }

  static Future<bool> logUser(
      LoginForm login, bool rememberMe, BuildContext context) async {
    try {
      var response = await _loginUserRequest(login);
      if (response.statusCode == 200) {
        var jsonRes = json.decode(response.body);
        _saveJsonInfoInSharedPref(
            jsonRes, login.username, login.password, rememberMe);
        try {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => new HomePage())
          );
          return true;
        }on FlutterError catch(e){
          print(e);
          print("Error while trying to go to homepage");
          return false;
        }

      } else {
        return false;
      }
    }on HttpException catch(e){
      print(e);
      print("Http exception");
      return false;
    }
  }

  static Future<bool> checkIfUserAlreadyLoggedIn(BuildContext context) async {
    String token = await SharedPreferenceService.getToken();
    if (token == null || token == "") return false;
    String username = await SharedPreferenceService.getUsername();
    if (username == null || username == "") return false;
    String password = await SharedPreferenceService.getPassword();
    if (password == null || password == "") return false;
    try {
      await UserService.logUser(new LoginForm(password,username), true, context);
    }on Exception catch(e){
      print(e);
      return false;
    }
    return true;
  }

  static registerUser(UserDto userDto, BuildContext context) async {
    var response = await _registerUserRequest(userDto);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw new Exception("Can't register user.");
    } else {
      logUser(new LoginForm(userDto.password, userDto.username), true, context);
    }
  }

  static Future<void> updateProfile(UserDto userDto) async {
    var response = await _updateUserProfile(userDto);
    if (response.statusCode != 200) {
      throw new Exception("Can't update profil");
    } else {
      var jsonRes = jsonDecode(response.body);

      SharedPreferenceService.setToken(jsonRes["token"]);
      SharedPreferenceService.setId(jsonRes["id"]);
      SharedPreferenceService.setUsername(userDto.username);
    }
  }

  static _saveJsonInfoInSharedPref(Map<String, dynamic> json, String username,
      String password, bool rememberMe) async {
    bool admin = false;
    if (rememberMe) {
      await SharedPreferenceService.setUsernamePassword(username, password);
    }
    await SharedPreferenceService.setToken(json["token"]);
    await SharedPreferenceService.setId(json["id"]);
    var jsonAuth = json["authorities"] as List;
    jsonAuth.forEach((auth){
      if(auth["authority"]=="ROLE_ADMIN")
        admin=true;
    });
    await SharedPreferenceService.setAdmin(admin);
  }

  static UserDto _fromJsonToUserDto(Map<String, dynamic> json) {
    return new UserDto.withId(json["user_id"], json["email"], json["firstName"],
        json["lastName"], json["username"]);
  }

  static String listToString(List<String> list) {
    String concat = "";
    list.forEach((item) {
      concat += item + ",";
    });
    return concat.substring(0, concat.length - 1);
  }

  static Future<UserDto> retrieveUserInfo() async {
    int id = await SharedPreferenceService.getId();
    var response = await getUserById(id);
    if (response.statusCode != 200) {
      throw new Error();
    } else {
      var jsonRes = jsonDecode(response.body);
      return _fromJsonToUserDto(jsonRes);
    }
  }

  static logout(BuildContext context) async {
    await SharedPreferenceService.logout();

    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
