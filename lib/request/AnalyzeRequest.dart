import 'package:noticetracker/enumerate/EmotionEnum.dart';

class AnalyzedRequest {
  int id;
  double positive;
  double negative;
  double neutral;
  double unAnalyzed;

  AnalyzedRequest(
      this.id, this.positive, this.negative, this.neutral, this.unAnalyzed);

  SentimentEnum getSentiment() {
    if (neutral >= positive && neutral >= negative) return SentimentEnum.neutral;
    if (positive >= neutral && positive >= negative)
      return SentimentEnum.positive;
    if (negative >= neutral && negative >= positive)
      return SentimentEnum.negative;
    else
      return SentimentEnum.not_processed;
  }

  AnalyzedRequest.none();

  AnalyzedRequest.withJson(Map<String, dynamic> json) {
    id = json["analyze_r_id"];
    positive = json["positive"];
    negative = json["negative"];
    neutral = json["neutral"];
    unAnalyzed = json["unanalyzed"];
  }

  static AnalyzedRequest parseResponseForAnalyzedRequest(Map<String, dynamic> jsonDecode) {
    if (jsonDecode != null) {
      return AnalyzedRequest.withJson(jsonDecode);
    }
    return AnalyzedRequest.none();
  }

  double getSentimentPercentage(SentimentEnum emotionEnum){
    double total = positive+negative+neutral+unAnalyzed;
    switch(emotionEnum){
      case SentimentEnum.positive:
        return (positive/total)*100;

      case SentimentEnum.neutral:
        return (neutral/total)*100;

      case SentimentEnum.negative:
        return (negative/total)*100;

      case SentimentEnum.not_processed:
        return 0;
    }
    return 0;
  }


  String getSentimentSentence(){
    SentimentEnum emotionEnum = getSentiment();
    switch(emotionEnum){
      case SentimentEnum.positive:
        return "positive at : ${getSentimentPercentage(emotionEnum).toStringAsFixed(2)}%";

      case SentimentEnum.neutral:
        return "neutral at : ${getSentimentPercentage(emotionEnum).toStringAsFixed(2)}%";

      case SentimentEnum.negative:
        return "negative at : ${getSentimentPercentage(emotionEnum).toStringAsFixed(2)}%";

      case SentimentEnum.not_processed:
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

  Map<String, dynamic> toJson() => {
    "id":id,
    "positive":positive,
    "negative":negative,
    "neutral":neutral,
    "unanalyzed":unAnalyzed,
  };
}
