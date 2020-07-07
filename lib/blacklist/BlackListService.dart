import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:noticetracker/blacklist/BlackList.dart';
import 'package:noticetracker/sharedPref/SharedPreferenceService.dart';

class BlackListService {

  static String url="https://pa2020-api.herokuapp.com/api/v1/blacklist/";
  static String send="send/";

  static Future<http.Response> _getBlackListWord() async {
    String token = await SharedPreferenceService.getToken();

    return http.get(url, headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer " + token,
        });
  }

  static Future<http.Response> _sendBlackList(String sentence) async {
    String token = await SharedPreferenceService.getToken();
    return http.post(url+send,
        body: jsonEncode(<String, Object>
        {
          "sentence":sentence
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer " + token,
        });
  }

  static Future<http.Response> _deleteBlackList(int id) async {
    String token = await SharedPreferenceService.getToken();
    return http.delete(url+"$id", headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer " + token,
    });
  }


  static Future<List<BlackListWord>> getList() async {
    var response = await _getBlackListWord();
    if(response.statusCode==200){
      List<BlackListWord> blackList=[];
      var jsonBody = jsonDecode(response.body);
      var blackListJson = jsonBody as List;
      for(int i=0; i<blackListJson.length; i++){
        blackList.add(BlackListWord.withJson(blackListJson[i]));
      }
      blackList.sort((BlackListWord a,BlackListWord b)=>a.sentence.toLowerCase().compareTo(b.sentence.toLowerCase()));
      return blackList;
    }
    throw new Exception("Error while fetching black listed word!");
  }


  static Future<bool> sendBlackListWord(String sentence) async {
    var response = await _sendBlackList(sentence);
    if(response.statusCode==200){
      return true;
    }
    else if(response.statusCode==500){
      throw new Exception("The sentence already exist!");
    }else{
      throw new Exception("Enter a proper sentence in the field!");
    }
  }

  static Future<bool> deleteBlackListWord(int id) async {
    var response = await _deleteBlackList(id);
    if(response.statusCode==200){
      return true;
    }
    else{
      throw new Exception("Couldn't delete the word!");
    }
  }

}