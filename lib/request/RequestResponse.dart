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
    if (neutral > positive &&
        neutral > negative)
      return EmotionEnum.neutral;
    if (positive > neutral &&
        positive > negative)
      return EmotionEnum.positive;
    if (negative > neutral &&
        negative > positive)
      return EmotionEnum.negative;
    else
      return EmotionEnum.not_processed;
  }


}
