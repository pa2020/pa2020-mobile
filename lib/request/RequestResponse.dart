
class RequestResponse {

  var positive;
  var negative;
  var neutral;
  int total;
  String word;
  int requestId;

  RequestResponse(this.positive, this.negative, this.neutral, this.total,
      this.word, this.requestId);

  @override
  String toString() {
    return 'RequestResponse{positive: $positive, negative: $negative, neutral: $neutral, total: $total, word: $word, request_id: $requestId}';
  }


}