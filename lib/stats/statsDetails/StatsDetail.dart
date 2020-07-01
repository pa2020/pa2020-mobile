
import '../word/Word.dart';

class StatsDetail{

  int id;
  int analyzeQuantity;
  double averageFeeling;
  double positiveComment;
  double negativeComment;
  double neutralComment;
  DateTime createdTime;
  Word word;

  StatsDetail(this.id, this.analyzeQuantity, this.averageFeeling,
      this.positiveComment, this.negativeComment, this.neutralComment,
      this.createdTime, this.word);


  StatsDetail.withJson(Map<String, dynamic> json){
    id = json["id"];
    analyzeQuantity = json["analyze_quantity"];
    averageFeeling = json["average_feeling"];
    positiveComment = json["positive_comment"];
    negativeComment = json["negative_comment"];
    neutralComment = json["neutral_comment"];
    if (json["created_time"] != null)
      createdTime = DateTime.parse(json["created_time"]);
    else
      createdTime = DateTime.now();
    
    word = Word.withJson(json["words"]) ;
  }

}