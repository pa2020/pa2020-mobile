
class LoginDto {
  String _username;
  String _password;

  LoginDto(this._username, this._password);

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  @override
  String toString() {
    return 'LoginDto{_username: $_username, _password: $_password}';
  }


}