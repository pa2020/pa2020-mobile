
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noticetracker/enumerate/SharedPrefEnum.dart';
import 'package:noticetracker/signIn/LoginForm.dart';
import 'package:noticetracker/user/UserDto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage.dart';

class UserService{

  static Future<http.Response> _loginUserRequest(LoginForm login) async {

    return http.post("https://pa2020-api.herokuapp.com/api/v1/auth/signin",
        body : jsonEncode(<String, String>{
          "password": login.password,
          "username": login.username
        }),
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }

  static Future<http.Response> _registerUserRequest(UserDto userDto) async {

    return http.post("https://pa2020-api.herokuapp.com/api/v1/auth/signup",
        body : jsonEncode(<String, String>{
          "email": userDto.email,
          "firstname": userDto.firstname,
          "lastname": userDto.lastname,
          "password": userDto.password,
          "role": "["+listToString(userDto.role)+"]",
          "username": userDto.username
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
    });
  }


  static Future<http.Response> _updateUserProfile(UserDto userDto){

    return http.put("https://pa2020-api.herokuapp.com/api/v1/auth/signup", body: jsonEncode(userDto), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }

  static Future<UserDto> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(EnumToString.parse(SharedPrefEnum.id));
    String token = prefs.getString(EnumToString.parse(SharedPrefEnum.token));
    var res = http.put("https://pa2020-api.herokuapp.com/api/v1/users/$id", headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-",
      "Authorization": "Bearer "+token,
    });
    return new UserDto("test@mail.com", "firstname", "lastname", "12345", new List.from(["client"]), "username");
  }


  static Future<void> logUser(LoginForm login, BuildContext context) async {
    var response = await _loginUserRequest(login);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Logged in");
      var jsonRes = json.decode(response.body);
      _saveJsonInfoInSharedPref(jsonRes, login.username, login.password);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new HomePage()));
    }else  {
      Fluttertoast.showToast(msg: "Can't loggin");
    }
  }

  static Future<void> checkIfUserAlreadyLoggedIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(EnumToString.parse(SharedPrefEnum.token));
    if(token==null || token=="")
      return;
    String username = prefs.getString(EnumToString.parse(SharedPrefEnum.username));
    if(username==null || username=="")
      return;
    String password = prefs.getString(EnumToString.parse(SharedPrefEnum.password));
    if(password==null || password=="")
      return;

    UserService.logUser(new LoginForm(username, password), context);
  }


  static registerUser(UserDto userDto) async {
    var response = await _registerUserRequest(userDto);
    print('Response status: ${response.statusCode}');
    var res = response.body;
    print(res);
    if( response.statusCode!=200){
      Fluttertoast.showToast(msg: "Cant registered user");
      throw new Error();
    }else {
      Fluttertoast.showToast(msg: "User registered");
      var jsonRes = jsonDecode(response.body);
      _saveJsonInfoInSharedPref(jsonRes, userDto.username, userDto.password);
    }
  }

  static updateProfile(UserDto userDto) async {
    var response = await _updateUserProfile(userDto);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if( response.statusCode!=200){
      throw new Error();
    }else {
      Fluttertoast.showToast(msg: "Profile updated");
      var jsonRes = jsonDecode(response.body);
      _saveJsonInfoInSharedPref(jsonRes, userDto.username, userDto.password);
    }
  }


  static _saveJsonInfoInSharedPref(Map<String, dynamic> json, String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumToString.parse(SharedPrefEnum.username), username);
    prefs.setString(EnumToString.parse(SharedPrefEnum.password), password);
    prefs.setString(EnumToString.parse(SharedPrefEnum.token), json["token"]);
    prefs.setInt(EnumToString.parse(SharedPrefEnum.id), json["id"]);
  }

  static _fromJsonToUserDto(Map<String, dynamic> json){

  }
  
  static String listToString(List<String> list){
    String concat = "";
    list.forEach((item) {
      concat+=item+",";
    });
    return concat.substring(0,concat.length-1);
  }
}