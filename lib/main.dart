import 'package:flutter/material.dart';
import 'package:noticetracker/signIn/SignInScreen.dart';
import 'package:noticetracker/HomePage.dart';
import 'package:noticetracker/signUp/SignUpScreen.dart';

void main() => runApp(MaterialApp(
  home: SignInScreen(),
  routes:  <String, WidgetBuilder>{
    "/home": (BuildContext context) => new HomePage(),
    "/signUp": (BuildContext context) => new SignUpScreen(),
    "/signIn": (BuildContext context) => new SignInScreen(),
  },
));

