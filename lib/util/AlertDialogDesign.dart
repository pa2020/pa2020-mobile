
import 'package:flutter/material.dart';
import 'package:noticetracker/user/UserService.dart';

import 'Spinner.dart';

class AlertDialogDesign {

  static Widget goodAlertDialog(BuildContext context, String message, String title) {
    return Container(
      alignment: Alignment.center,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          RaisedButton(
            padding: EdgeInsets.all(15),
            color: Color(0xFF21f3e7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: Text("Ok",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ],
        elevation: 24,
      ),
    );
  }

  static Widget badAlertDialog(BuildContext context, String message, String title) {
    return Container(
      alignment: Alignment.center,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          RaisedButton(
            padding: EdgeInsets.all(15),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: Text("Ok",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ],
        elevation: 24,
      ),
    );
  }
  static Widget futureAlertDialog(BuildContext context, String title, Future future) {
    return Container(
      alignment: Alignment.center,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text(title),
        content: FutureBuilder(
          future: future,
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if((asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData)
                || asyncSnapshot.connectionState==ConnectionState.none){
              showDialog(context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return AlertDialogDesign.badAlertDialog(context, "Error", "Can't proceed!");
                  }
              );
              return Center(
                  child: Text("Try turning your wifi or data services",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    ),));
            }
            else if(asyncSnapshot.connectionState!=ConnectionState.done){
              return Spinner.startSpinner(Colors.blue);
            }
            else if(asyncSnapshot.hasError){
              return Text("Error : ${asyncSnapshot.hasError}");
            }else {
              return Text("Done");
            }
          },
        ),
        actions: <Widget>[
          RaisedButton(
            padding: EdgeInsets.all(15),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: Text("Ok",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ],
        elevation: 24,
      ),
    );
  }

  static Widget disconnectionAlertDialog(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text("Disconnection"),
        content: Text("You are now logged out"),
        actions: <Widget>[
          RaisedButton(
            padding: EdgeInsets.all(15),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: Text("Ok",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: ()=> UserService.logout(context),
          ),
        ],
        elevation: 24,
      ),
    );
  }
}