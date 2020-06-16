
class Request {

  int _id;
  String _state;
  DateTime _createdAt;
  String _sentence;

  Request(this._state, this._createdAt, this._sentence);

  Request.withId(this._id, this._state, this._createdAt, this._sentence);

  String get sentence => _sentence;

  set sentence(String value) {
    _sentence = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Request{_id: $_id, _state: $_state, _createdAt: $_createdAt, _sentence: $_sentence}';
  }


}