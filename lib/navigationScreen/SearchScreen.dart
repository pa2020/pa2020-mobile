import 'package:flutter/material.dart';
import 'package:noticetracker/util/Spinner.dart';
import 'package:noticetracker/request/RequestResponse.dart';
import 'package:noticetracker/request/RequestService.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _requestSentence = "";

  Future<RequestResponse> _getResponse;
  String _radioBtn = "twitter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Try to type any word",
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue))),
              onChanged: (String value) {
                setState(() {
                  _requestSentence = value;
                });
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                onPressed: () {
                  setState(() {
                    _getResponse = RequestService.sendRequest(_requestSentence, context);
                  });
                },
                color: Color(0xFF21f3e7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            _generateFutureBuilder(),
            _generateRadioButton()
          ],
        ),
      )),
    );
  }

  Widget _generateFutureBuilder(){
    return FutureBuilder(
      future: _getResponse,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if((asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData)
            || asyncSnapshot.connectionState==ConnectionState.none){
          return Text("Go ahead, and send a word to analyze !");
        }
        else if(asyncSnapshot.connectionState!=ConnectionState.done){
          return Spinner.startSpinner(Colors.blue);
        }
        else if(asyncSnapshot.hasError){
          return Text("Error : ${asyncSnapshot.hasError}");
        }else {

          return Text("Your request has been sent !",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
        }
      },
    );
  }

  Widget _generateRadioButton() {
    return Column(
      children: [
        ListTile(
          title: const Text('Twitter'),
          leading: Radio(
            value: _radioBtn,
            groupValue: _radioBtn,
            onChanged: (String s) => print(s),
          ),
        ),
        ListTile(
          title: const Text('Facebook'),
          leading: Radio(
            value: "FaceBook",
            onChanged: (String s) => print(s),
            groupValue: _radioBtn,
          ),
          enabled: false,
        )
      ],
    );
  }
}
