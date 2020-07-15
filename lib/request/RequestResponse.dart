import 'package:noticetracker/enumerate/EmotionEnum.dart';

class RequestResponse {
  double positive;
  double negative;
  double neutral;
  int total;
  String word;
  int requestId;

  RequestResponse(this.positive, this.negative, this.neutral, this.total,
      this.word, this.requestId);

  @override
  String toString() {
    return 'RequestResponse{positive: $positive, negative: $negative, neutral: $neutral, total: $total, word: $word, request_id: $requestId}';
  }

  getSentiment() {
    if(neutral==positive && positive==negative)
      return SentimentEnum.empty;
    if (neutral > positive &&
        neutral > negative)
      return SentimentEnum.neutral;
    if (positive > neutral &&
        positive > negative)
      return SentimentEnum.positive;
    if (negative > neutral &&
        negative > positive)
      return SentimentEnum.negative;
    else
      return SentimentEnum.not_processed;
  }


}
