import 'package:flutter/material.dart';
import 'package:noticetracker/signIn/LoginForm.dart';
import 'package:noticetracker/user/UserService.dart';

class SignInScreen extends StatefulWidget {

  @override
    _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{
  bool _rememberMe = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  bool _obscureTextPwd = true;

  @override
  Widget build(BuildContext context) {
    UserService.checkIfUserAlreadyLoggedIn(context);

    return Scaffold(
      appBar: AppBar(
        title: new Center(child: new Text("Sign In", style: TextStyle(fontSize: 25),textAlign: TextAlign.center,))
      ),
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
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
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
                        controller: usernameController,

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
                        obscureText: _obscureTextPwd,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,
                              color: Colors.white,),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureTextPwd ? Icons.visibility : Icons.visibility_off),
                              onPressed: (){
                                setState(() {
                                  _obscureTextPwd=!_obscureTextPwd;
                                });
                              },
                            ),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.white54),
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))
                        ),
                        controller: passwordController,
                      ),

                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                      UserService.logUser(new LoginForm(passwordController.text, usernameController.text), _rememberMe,context).whenComplete(() => {
                        
                      });
                    } ,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Text("LOG IN", style: TextStyle(color: Color(0xFF21f3e7), fontSize: 20),),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20),
                  child: Text("- OR -",
                    style: TextStyle(color :Colors.white),),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 5),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed("/signUp");
                  },
                    child: Text(
                        "Register a user",
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  startSpinner(){

  }
  stopSpinner(){

  }
}