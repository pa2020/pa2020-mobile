import 'dart:convert';

import 'package:noticetracker/enumerate/EmotionEnum.dart';

import 'AnalyzeRequest.dart';

class Request {
  int requestId;
  String sentence;
  String state;
  DateTime createTime;
  DateTime updateTime;
  AnalyzedRequest analyzedRequest;

  Request(this.requestId, this.sentence, this.state, this.createTime,
      this.updateTime, this.analyzedRequest);

  @override
  String toString() {
    return 'Request{requestId: $requestId, sentence: $sentence, state: $state, createTime: $createTime, updateTime: $updateTime, analyzedRequest: $analyzedRequest}';
  }

  Request.withJson(Map<String, dynamic> json) {
    requestId = json["request_id"];
    sentence = json["sentence"];
    state = json["state"];
    if (json["created_time"] != null)
      createTime = DateTime.parse(json["created_time"]);
    else
      createTime = DateTime.now();

    if (json["update_time"] != null)
      updateTime = DateTime.parse(json["update_time"]);
    else
      updateTime = DateTime.now();

    analyzedRequest =
        AnalyzedRequest.parseResponseForAnalyzedRequest(json["analyzeRequest"]);
  }

  Request.withJsonForAnalyzeReq(Map<String, dynamic> json) {
    requestId = json["request_id"];
    sentence = json["sentence"];
    state = json["state"];
    if (json["created_time"] != null)
      createTime = DateTime.parse(json["created_time"]);
    else
      createTime = DateTime.now();

    if (json["update_time"] != null)
      updateTime = DateTime.parse(json["update_time"]);
    else
      updateTime = DateTime.now();

    analyzedRequest =
        AnalyzedRequest.parseResponseForAnalyzedRequest(jsonDecode(json["analyzeRequest"]));
  }

  Map<String, dynamic> toJson() => {
    "request_id":requestId,
    "sentence":sentence,
    "state":state,
    "created_time":createTime.toString(),
    "update_time":updateTime.toString(),
    "analyzeRequest":jsonEncode(analyzedRequest.toJson()),
  };


  getAnalysedRequestSentimentPercentage(SentimentEnum sentiment){
    return analyzedRequest.getSentimentPercentage(sentiment);
  }

}
