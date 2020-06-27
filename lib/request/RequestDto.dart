
class RequestDto {
  DateTime createdAt;
  String sentence;

  RequestDto(this.createdAt, this.sentence);

  RequestDto.withId(this.createdAt, this.sentence);

  @override
  String toString() {
    return 'Request{_createdAt: $createdAt, _sentence: $sentence}';
  }


}