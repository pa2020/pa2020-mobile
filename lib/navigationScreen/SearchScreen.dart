import 'package:flutter/material.dart';
import 'package:noticetracker/enumerate/EmotionEnum.dart';
import 'package:noticetracker/request/RequestService.dart';
import 'package:noticetracker/request/RequestResponse.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _requestSentence = "";

  DateTime _dateTime;


  Image _img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding : false,
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.blue))
                    ),
                    onChanged: (String value){
                      setState(() {
                        _requestSentence = value;
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Text("Pick a starting date : "),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: _getLastWeek(),
                              lastDate: DateTime.now())
                              .then((date)=>_dateTime=date);
                        },
                      ),
                      Text(_dateTime==null ? "" : _dateTime.toIso8601String())
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
                      onPressed: () {
                        setState(() {
                          RequestService.sendRequest(_requestSentence).then((value){
                            _img=chargeImageFromRequestResponse(value);
                          });
                        });
                      } ,
                      color: Color(0xFF21f3e7),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                  ),
                  (_img==null?Text("Waiting for Response"):_img)
                ],
              ),
            )
        ),
      );
  }

  static Image chargeImageFromRequestResponse(RequestResponse requestResponse){
    if(requestResponse!=null) {
      switch (getSentiment(requestResponse)) {
        case EmotionEnum.positive:
          return Image.asset('assets/sentiment_meter_positive.png', fit: BoxFit.fitWidth);
        case EmotionEnum.neutral:
          return Image.asset('assets/sentiment_meter_neutral.png', fit: BoxFit.fitWidth);
        case EmotionEnum.negative:
          return Image.asset('assets/sentiment_meter_negative.png', fit: BoxFit.fitWidth);
        case EmotionEnum.not_processed:
          return Image.asset('assets/sentiment_meter_not_processed.png', fit: BoxFit.fitWidth);
        default :
          return Image.asset('assets/sentiment_meter_not_processed.png', fit: BoxFit.fitWidth);
      }
    }
    return Image.asset('assets/sentiment_meter.png', fit: BoxFit.fitWidth);
  }

  static EmotionEnum getSentiment(RequestResponse requestResponse){
    if(requestResponse.neutral>requestResponse.positive && requestResponse.neutral>requestResponse.negative)
      return EmotionEnum.neutral;
    if(requestResponse.positive>requestResponse.neutral && requestResponse.positive>requestResponse.negative)
      return EmotionEnum.positive;
    if(requestResponse.negative>requestResponse.neutral && requestResponse.negative>requestResponse.positive)
      return EmotionEnum.negative;
    else
      return EmotionEnum.not_processed;

  }

  DateTime _getLastWeek(){
    return DateTime.now().subtract(Duration(days: 7));
  }
}
