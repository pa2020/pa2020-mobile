import 'package:flutter/material.dart';
import 'package:noticetracker/user/UserDto.dart';
import 'package:noticetracker/user/UserService.dart';
import 'package:noticetracker/util/AlertDialogDesign.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  bool _obscureTextPwd1 = true;
  bool _obscureTextPwd2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: new Center(
                child: new Text(
          "Register",
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ))),
        body: Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.blue, const Color(0xFF21f3e7)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight)),
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Username",
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(
                            color: Colors.white10,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: "Enter your username",
                                hintStyle: TextStyle(color: Colors.white54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
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
                          Text(
                            "Password",
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(
                            color: Colors.white10,
                          ),
                          TextFormField(
                            obscureText: _obscureTextPwd1,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureTextPwd1
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextPwd1 = !_obscureTextPwd1;
                                    });
                                  },
                                ),
                                hintText: "Enter your password",
                                hintStyle: TextStyle(color: Colors.white54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            controller: password1Controller,
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
                          TextFormField(
                            obscureText: _obscureTextPwd2,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureTextPwd2
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextPwd2 = !_obscureTextPwd2;
                                    });
                                  },
                                ),
                                hintText: "Confirm the password",
                                hintStyle: TextStyle(color: Colors.white54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            controller: password2Controller,
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
                          Text(
                            "Email",
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(
                            color: Colors.white10,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.white,
                                ),
                                hintText: "Enter your mail",
                                hintStyle: TextStyle(color: Colors.white54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
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
                          Text(
                            "Firstname",
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(
                            color: Colors.white10,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                                hintText: "Enter your firstname",
                                hintStyle: TextStyle(color: Colors.white54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
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
                          Text(
                            "Lastname",
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(
                            color: Colors.white10,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                                hintText: "Enter your lastname",
                                hintStyle: TextStyle(color: Colors.white54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            controller: lastNameController,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 50.0),
                        onPressed: () {
                          if (oneFieldIsEmpty()) {
                            showDialog(context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context){
                                  return AlertDialogDesign.badAlertDialog(
                                      context,"You can't have a blank field","Please complete the field properly");
                                }
                            );

                          } else if (password1Controller.text !=
                              password2Controller.text) {
                            showDialog(context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context){
                                  return AlertDialogDesign.badAlertDialog(
                                      context,"Password doesnt match !","Please complete the field properly");
                                }
                            );

                          } else if (!RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(emailController.text)) {
                            showDialog(context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context){
                                  return AlertDialogDesign.badAlertDialog(
                                      context,"Please enter a valid mail address","Please complete the field properly");
                                }
                            );
                          } else {
                            try{
                              UserService.registerUser(
                                  new UserDto(
                                      emailController.text,
                                      firstNameController.text,
                                      lastNameController.text,
                                      password1Controller.text,
                                      new List.from(["client"]),
                                      usernameController.text),
                                  context).whenComplete((){

                                    showDialog(context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context){
                                      return AlertDialogDesign.goodAlertDialog(context,"The user is register", "Registration complete");
                                    }
                                );

                              });
                            }on Exception catch(e){
                              showDialog(context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context){
                                    return AlertDialogDesign.badAlertDialog(context,e.toString(), "Registration error");
                                  }
                              );
                            }
                          }
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Register",
                          style:
                              TextStyle(color: Color(0xFF21f3e7), fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ))
          ]),
        ));
  }

  bool oneFieldIsEmpty() {
    return usernameController.text.isEmpty &&
        password1Controller.text.isEmpty &&
        password2Controller.text.isEmpty &&
        emailController.text.isEmpty &&
        firstNameController.text.isEmpty &&
        lastNameController.text.isEmpty;
  }

}
