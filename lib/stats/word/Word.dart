

class Word {
  int id;

  String sentence;

  int occurrence;

  Word(this.id, this.sentence, this.occurrence);

  Word.withJson(Map<String, dynamic> json){
    id = json["id"];
    sentence = json["word"];
    occurrence = json["occurence"];
  }


}