
class LoginForm {

  String _password;
  String _username;

  LoginForm(this._password, this._username);

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
    return 'LoginForm{_password: $_password, _username: $_username}';
  }

}