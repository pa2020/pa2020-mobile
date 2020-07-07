
class BlackListWord {
  int id;
  String sentence;

  BlackListWord(this.id, this.sentence);

  BlackListWord.withJson(Map<String, dynamic> json){
      id=json["id"];
      sentence=json["sentence"];
  }

}