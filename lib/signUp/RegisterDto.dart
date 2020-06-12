
class RegisterDto {

  String _email;
  String _firstname;
  String _lastname;
  String _password1;
  String _password2;
  String _role;
  String _username;

  RegisterDto(this._email, this._firstname, this._lastname, this._password1,
      this._password2, this._role, this._username);

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get role => _role;

  set role(String value) {
    _role = value;
  }

  String get password2 => _password2;

  set password2(String value) {
    _password2 = value;
  }

  String get password1 => _password1;

  set password1(String value) {
    _password1 = value;
  }

  String get lastname => _lastname;

  set lastname(String value) {
    _lastname = value;
  }

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  @override
  String toString() {
    return 'RegisterDto{_email: $_email, _firstname: $_firstname, _lastname: $_lastname, _password1: $_password1, _password2: $_password2, _role: $_role, _username: $_username}';
  }


}