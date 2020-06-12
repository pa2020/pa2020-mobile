
class UserDto{

  String _email;
  String _firstname;
  String _lastname;
  String _password;
  List<String> _role;
  String _username;

  UserDto(this._email, this._firstname, this._lastname, this._password,
      this._role, this._username);

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  List<String> get role => _role;

  set role(List<String> value) {
    _role = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
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
    return 'UserDto{_email: $_email, _firstname: $_firstname, _lastname: $_lastname, _password: $_password, _role: $_role, _username: $_username}';
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      json["email"],
      json["firstname"],
      json["lastname"],
      json["password"],
      json["role"],
      json["username"]);
  }

}