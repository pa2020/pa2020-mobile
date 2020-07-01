import 'package:noticetracker/enumerate/EmotionEnum.dart';

class AnalyzedRequest {
  int id;
  double positive;
  double negative;
  double neutral;
  double unAnalyzed;

  AnalyzedRequest(
      this.id, this.positive, this.negative, this.neutral, this.unAnalyzed);

  EmotionEnum getSentiment() {
    if (neutral >= positive && neutral >= negative) return EmotionEnum.neutral;
    if (positive >= neutral && positive >= negative)
      return EmotionEnum.positive;
    if (negative >= neutral && negative >= positive)
      return EmotionEnum.negative;
    else
      return EmotionEnum.not_processed;
  }

  AnalyzedRequest.none();

  AnalyzedRequest.withJson(Map<String, dynamic> json) {
    id = json["analyze_r_id"];
    positive = json["positive"];
    negative = json["negative"];
    neutral = json["neutral"];
    unAnalyzed = json["unanalyzed"];
  }

  static AnalyzedRequest parseResponseForAnalyzedRequest(jsonDecode) {
    if (jsonDecode != null) {
      return AnalyzedRequest.withJson(jsonDecode);
    }
    return AnalyzedRequest.none();
  }

  double _getSentimentPercentage(EmotionEnum emotionEnum){
    double total = positive+negative+neutral+unAnalyzed;
    switch(emotionEnum){
      case EmotionEnum.positive:
        return (positive/total)*100;

      case EmotionEnum.neutral:
        return (neutral/total)*100;

      case EmotionEnum.negative:
        return (negative/total)*100;

      case EmotionEnum.not_processed:
        return 0;
    }
    return 0;
  }


  String getSentimentSentence(){
    EmotionEnum emotionEnum = getSentiment();
    switch(emotionEnum){
      case EmotionEnum.positive:
        return "positive at : ${_getSentimentPercentage(emotionEnum).toStringAsFixed(2)}%";

      case EmotionEnum.neutral:
        return "neutral at : ${_getSentimentPercentage(emotionEnum).toStringAsFixed(2)}%";

      case EmotionEnum.negative:
        return "negative at : ${_getSentimentPercentage(emotionEnum).toStringAsFixed(2)}%";

      case EmotionEnum.not_processed:
        return "";

    }
    return "";
  }


  @override
  String toString() {
    return 'AnalyzedRequest{id: $id, positive: $positive, negative: $negative, neutral: $neutral, unanalyzed: $unAnalyzed}';
  }

  bool hasNullElement(){
    if(positive==null
    || negative==null
    || neutral==null)
      return true;
    return false;
  }
}
