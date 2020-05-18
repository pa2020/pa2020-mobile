import 'package:flutter/material.dart';
import 'package:noticetracker/State.dart';

class Request {
  States _state;
  DateTime _createdAt;
  String _sentence;
  bool _positivy;
  bool _neutral;
  bool _negative;

  Request(this._state, this._createdAt, this._sentence, this._positivy,
      this._neutral, this._negative);

  bool get negative => _negative;

  set negative(bool value) {
    _negative = value;
  }

  bool get neutral => _neutral;

  set neutral(bool value) {
    _neutral = value;
  }

  bool get positivy => _positivy;

  set positivy(bool value) {
    _positivy = value;
  }

  String get sentence => _sentence;

  set sentence(String value) {
    _sentence = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  States get state => _state;

  set state(States value) {
    _state = value;
  }


}