import 'package:flutter/material.dart';
import 'package:noticetracker/State.dart';
import 'package:noticetracker/enumerate/EmotionEnum.dart';

class AnalyzedRequest {
  int id;
  double positive;
  double negative;
  double neutral;
  double unanalyzed;

  AnalyzedRequest(this.id, this.positive, this.negative,
      this.neutral, this.unanalyzed);


  EmotionEnum getSentiment(){
    if(neutral>=positive && neutral>=negative)
      return EmotionEnum.neutral;
    if(positive>=neutral && positive>=negative)
      return EmotionEnum.positive;
    if(negative>=neutral && negative>=positive)
      return EmotionEnum.negative;
    else
      return EmotionEnum.not_processed;

  }

  AnalyzedRequest.none();

  AnalyzedRequest.withJson(Map<String, dynamic> json){
    id = json["analyze_r_id"];
    positive = json["positive"];
    negative = json["negative"];
    neutral = json["neutral"];
    unanalyzed = json["unanalyzed"];
  }

  static AnalyzedRequest parseResponseForAnalyzedRequest(jsonDecode) {
    if(jsonDecode!=null) {
      return AnalyzedRequest.withJson(jsonDecode);
    }
    return AnalyzedRequest.none();
  }

}