import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noticetracker/user/UserDto.dart';
import 'package:noticetracker/user/UserService.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<UserDto> _userInfo;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userInfo=UserService.retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userInfo,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if((asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData)
            || asyncSnapshot.connectionState==ConnectionState.none){
          return Center(child: Text("Nothing to display"));
        }
        else if(asyncSnapshot.connectionState!=ConnectionState.done){
          return _startSpinner();
        }
        else if(asyncSnapshot.hasError){
          return Text("Error : ${asyncSnapshot.hasError}");
        }else {
          fillField(asyncSnapshot.data);
          return _generateScaffold();
        }
      },
    );
  }

  Widget _startSpinner() {
    return Center(
      child: SpinKitDualRing(
        color: Colors.blue,
      ),
    );
  }



  _generateScaffold(){
    return Scaffold(
        body: Container(
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          ),
                          Divider(
                            color: Colors.white10,
                          ),
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.black54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.black))),
                            controller: usernameController,
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
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.black,
                                ),
                                hintText: "Enter your mail",
                                hintStyle: TextStyle(color: Colors.black54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.black))),
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
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                                hintText: "Enter your firstname",
                                hintStyle: TextStyle(color: Colors.black54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.black))),
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
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                                hintText: "Enter your lastname",
                                hintStyle: TextStyle(color: Colors.black54),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.black))),
                            controller: lastNameController,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              onPressed: () {
                                if (oneFieldIsEmpty()) {
                                  Fluttertoast.showToast(
                                      msg: "You can't have a blank field");
                                } else if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(emailController.text)) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter a valid mail address");
                                } else {
                                  try {
                                    UserService.updateProfile(new UserDto(
                                        emailController.text,
                                        firstNameController.text,
                                        lastNameController.text,
                                        "",
                                        [""],
                                        ""));
                                  } on Exception catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                }
                              },
                              color: Color(0xFF21f3e7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Modify",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              onPressed: () {
                                Fluttertoast.showToast(msg: "Disconnecting");
                                UserService.logout(context);
                              },
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Disconnect",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ]),
        ));
  }

  bool oneFieldIsEmpty() {
    return emailController.text.isEmpty &&
        firstNameController.text.isEmpty &&
        lastNameController.text.isEmpty;
  }

  fillField(UserDto userDto) {
    usernameController.text = userDto.username;
    emailController.text = userDto.email;
    firstNameController.text = userDto.firstName;
    lastNameController.text = userDto.lastName;
  }

}
