import '../user/UserDto.dart';

class Queue {
  int id;
  int requestId;
  UserDto user;
  int position;
  int total;

  Queue(this.id, this.requestId, this.user, this.position, this.total);

  Queue.withJson(Map<String, dynamic> json) {
    var queue = json["queue"];
    id = queue["id"];
    requestId = queue["requestId"];
    position = json["position"] + 1;
    total = json["total"];
    user = UserDto.fromJson(queue['user']);
  }
}
