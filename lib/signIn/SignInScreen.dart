import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/enumerate/SharedPrefEnum.dart';
import 'package:noticetracker/user/LoginDto.dart';
import 'package:noticetracker/user/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {

  @override
    _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{
  bool _rememberMe = false;
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    checkIfUserAlreadyLoggedIn();

    return Scaffold(
      resizeToAvoidBottomPadding : false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors:[Colors.blue, const Color(0xFF21f3e7)],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight)
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 50.0
            ),
            child: Column(
              children: <Widget>[
                Text("Sign In",
                    style: TextStyle(color :Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Username",
                        style: TextStyle(color :Colors.white),),
                      Divider(
                        color: Colors.white10,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,
                              color: Colors.white,),
                            hintText: "Enter your username",
                            hintStyle: TextStyle(color: Colors.white54),
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))
                        ),
                        onSaved: (String value){
                          setState(() {
                            _username=value;
                          });
                        },

                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                      top: 10
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Password",
                        style: TextStyle(color :Colors.white),),
                      Divider(
                        color: Colors.white10,
                      ),
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,
                              color: Colors.white,),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.white54),
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))
                        ),
                          onSaved: (String value){
                            setState(() {
                              _password=value;
                            });
                          }

                      ),

                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(
                      right: 5.0,
                      top: 10.0
                  ),
                  child: FlatButton(
                    onPressed: ()=>print("Forgot password"),
                    child: Text(
                        "Forgot password ?",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool value){
                          setState(() {
                            _rememberMe = value;
                          });
                        },
                      ),
                      Text(
                          "Remember me",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 50.0),
                    onPressed: () {
                      logUser();
                    } ,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Text("LOG IN", style: TextStyle(color: Color(0xFF21f3e7), fontSize: 20),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> logUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumToString.parse(SharedPrefEnum.username), _username);
    prefs.setString(EnumToString.parse(SharedPrefEnum.password), _password);
    Navigator.of(context).pushNamed("/home");

  }

  Future<void> checkIfUserAlreadyLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(EnumToString.parse(SharedPrefEnum.token));
    if(token==null)
      return;
    String username = prefs.getString(EnumToString.parse(SharedPrefEnum.username));
    if(username==null)
      return;
    String password = prefs.getString(EnumToString.parse(SharedPrefEnum.password));
    if(password==null)
      return;

    UserService.loginUser(new LoginDto(username, password));
  }
}