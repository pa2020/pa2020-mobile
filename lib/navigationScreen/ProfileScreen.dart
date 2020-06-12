import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noticetracker/user/UserDto.dart';
import 'package:noticetracker/user/UserService.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  UserDto userInfo = retrieveUserInfo();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  bool _obscureTextPwd = true;
  bool _modifying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 50.0
                    ),
                    child: Column(
                      children: <Widget>[
                        Text("User Profile",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Username",),
                              Divider(
                                color: Colors.white10,
                              ),
                              TextFormField(
                                enabled: !_modifying,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person,
                                      color: Colors.black,),
                                    hintText: "Enter your username",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black))
                                ),
                                controller: usernameController,
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Password"),
                              Divider(
                                color: Colors.white10,
                              ),
                              TextFormField(
                                enabled: !_modifying,
                                obscureText: _obscureTextPwd,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock,
                                      color: Colors.black,),
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscureTextPwd ? Icons.visibility : Icons.visibility_off),
                                      onPressed: (){
                                        setState(() {
                                          _obscureTextPwd=!_obscureTextPwd;
                                        });
                                      },
                                    ),
                                    hintText: "Enter your password",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black))
                                ),
                                controller: passwordController,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Email"),
                              Divider(
                                color: Colors.white10,
                              ),
                              TextFormField(
                                enabled: !_modifying,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail_outline,
                                      color: Colors.black,),
                                    hintText: "Enter your mail",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black))
                                ),
                                controller: emailController,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Firstname"),
                              Divider(
                                color: Colors.white10,
                              ),
                              TextFormField(
                                enabled: !_modifying,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline,
                                      color: Colors.black,),
                                    hintText: "Enter your firstname",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black))
                                ),
                                controller: firstNameController,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Lastname"),
                              Divider(
                                color: Colors.white10,
                              ),
                              TextFormField(
                                enabled: !_modifying,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline,
                                      color: Colors.black,),
                                    hintText: "Enter your lastname",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.black))
                                ),
                                controller: lastNameController,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 50.0),
                            onPressed: () {
                              if(oneFieldIsEMpty()){
                                Fluttertoast.showToast(msg: "You can't have a blank field");
                              }
                              else if(!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(emailController.text)){
                                Fluttertoast.showToast(msg: "Please enter a valid mail address");
                              }
                              else {
                                UserService.updateProfile(new UserDto(
                                    emailController.text,
                                    firstNameController.text,
                                    lastNameController.text,
                                    passwordController.text,
                                    userInfo.role,
                                    usernameController.text));
                              }
                            } ,
                            color: Color(0xFF21f3e7),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            child: Text("Modify", style: TextStyle(color: Colors.white, fontSize: 15),),
                          ),
                        ),
                      ],)
                )
              ]
          ),
        )
    );
  }



  bool oneFieldIsEMpty(){
    return usernameController.text.isEmpty && passwordController.text.isEmpty &&
        emailController.text.isEmpty &&
        firstNameController.text.isEmpty && lastNameController.text.isEmpty;
  }

  static UserDto retrieveUserInfo() {
    //return await UserService.getUserInfo();
    return new UserDto("email@mail", "firsname", "lastname", "123456", new List.from(["client"]), "username");
  }
}
