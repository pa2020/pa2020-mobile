
import 'dart:convert';

import 'package:noticetracker/sharedPref/SharedPreferenceService.dart';
import 'package:http/http.dart' as http;
import 'package:noticetracker/stats/word/Word.dart';
import 'package:noticetracker/stats/statsDetails/StatsDetail.dart';

class StatsService {

  static final String baseUrl="https://pa2020-api.herokuapp.com/api/v1/";
  static final String wordListUrl="word";
  static final String statsWordUrl="stats?word=";


  static Future<http.Response>_getWordsList() async {
    String token = await SharedPreferenceService.getToken();
    return http.get(baseUrl + wordListUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer " + token,
        });
  }

  static Future<http.Response>_getStatsForWord(String word) async {
    String token = await SharedPreferenceService.getToken();
    return http.get(baseUrl + statsWordUrl+"$word",
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer " + token,
        });
  }

  static Future<List<Word>> getListOfWords() async {
    var response = await _getWordsList();
    if(response.statusCode==200){
      List<Word> words = [];
      var jsonBody = jsonDecode(response.body);
      var wordList = jsonBody as List;
      wordList.forEach((jsonWord){
        words.add(Word.withJson(jsonWord));
      });
      return words;
    }
    throw new Exception("Error while fetching list of words !");
  }

  static Future<List<StatsDetail>> getStatisticsForWord(String word) async {
    var response = await _getStatsForWord(word);
    if(response.statusCode==200){
      List<StatsDetail> stats = [];
      var jsonBody = jsonDecode(response.body);
      var statsList = jsonBody as List;
      statsList.forEach((jsonWord){
        stats.add(StatsDetail.withJson(jsonWord));
      });
      return stats;
    }
    throw new Exception("Error while fetching words statistics !");
  }

}