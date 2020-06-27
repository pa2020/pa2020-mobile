
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noticetracker/sharedPref/SharedPreferenceService.dart';
import 'package:noticetracker/signIn/LoginForm.dart';
import 'package:noticetracker/user/UserDto.dart';
import 'package:http/http.dart' as http;

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
    String roles = listToString(userDto.role);
    return http.post("https://pa2020-api.herokuapp.com/api/v1/auth/signup",
        body : jsonEncode(<String, Object>{
          "email": userDto.email,
          "firstname": userDto.firstname,
          "lastname": userDto.lastname,
          "password": userDto.password,
          "role": [roles],
          "username": userDto.username
        }),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    });
  }


  static Future<http.Response> _updateUserProfile(UserDto userDto, int id, token){

    return http.put("https://pa2020-api.herokuapp.com/api/v1/users/$id",
        body : jsonEncode(<String, Object>{
          "email": userDto.email,
          "firstName": userDto.firstname,
          "lastName": userDto.lastname
    }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer "+token,
        });
  }

  static Future<http.Response> getUserById(int id) async {
    String token = await SharedPreferenceService.getToken();
    return http.get("https://pa2020-api.herokuapp.com/api/v1/users/$id", headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-",
      "Authorization": "Bearer "+token,
    });
  }


  static Future<void> logUser(LoginForm login, bool rememberMe,BuildContext context) async {
    var response = await _loginUserRequest(login);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Logged in");
      var jsonRes = json.decode(response.body);
      _saveJsonInfoInSharedPref(jsonRes, login.username, login.password, rememberMe);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new HomePage()));
    }else  {
      Fluttertoast.showToast(msg: "Can't loggin");
    }
  }

  static Future<void> checkIfUserAlreadyLoggedIn(BuildContext context) async {
    String token = await SharedPreferenceService.getToken();
    if(token==null || token=="")
      return;
    String username = await SharedPreferenceService.getUsername();
    if(username==null || username=="")
      return;
    String password = await SharedPreferenceService.getPassword();
    if(password==null || password=="")
      return;

    UserService.logUser(new LoginForm(username,password), true,context);
  }


  static registerUser(UserDto userDto, BuildContext context) async {
    var response = await _registerUserRequest(userDto);
    var res = response.body;
    print(res);
    if( response.statusCode!=200){
      Fluttertoast.showToast(msg: "Cant registered user");
      throw new Error();
    }else {
      Fluttertoast.showToast(msg: "User registered");
      var jsonRes = jsonDecode(response.body);
      _saveJsonInfoInSharedPref(jsonRes, userDto.username, userDto.password, true);
      Navigator.of(context).pushNamed("/signIn");
    }
  }

  static updateProfile(UserDto userDto) async {
    int id = await SharedPreferenceService.getId();
    String token = await SharedPreferenceService.getToken();

    var response = await _updateUserProfile(userDto, id, token);
    if( response.statusCode!=200){
      Fluttertoast.showToast(msg: "Can't update the user info !");
      throw new Exception("Can't update profil");
    }else {
      Fluttertoast.showToast(msg: "Profile updated");
      var jsonRes = jsonDecode(response.body);

      SharedPreferenceService.setToken(jsonRes["token"]);
      SharedPreferenceService.setId(jsonRes["id"]);
      await SharedPreferenceService.setUsername(userDto.username);
    }
  }


  static _saveJsonInfoInSharedPref(Map<String, dynamic> json, String username, String password, bool rememberMe) async {
    if(rememberMe) {
      await SharedPreferenceService.setUsernamePassword(username, password);
    }
    await SharedPreferenceService.setToken(json["token"]);
    await SharedPreferenceService.setId(json["id"]);
  }

  static UserDto _fromJsonToUserDto(Map<String, dynamic> json){
    return new UserDto.withId(
      json["user_id"],
      json["email"],
      json["firstName"],
      json["lastName"],
      json["username"]);

  }

  static String listToString(List<String> list){
    String concat = "";
    list.forEach((item) {
      concat+=item+",";
    });
    return concat.substring(0,concat.length-1);
  }



  static Future<UserDto> retrieveUserInfo() async {
    int id = await SharedPreferenceService.getId();
    var response = await getUserById(id);
    if( response.statusCode!=200){
      throw new Error();
    }else {
      var jsonRes = jsonDecode(response.body);
      return _fromJsonToUserDto(jsonRes);
    }
  }

  static logout(BuildContext context) async {
    await SharedPreferenceService.logout();

    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

}