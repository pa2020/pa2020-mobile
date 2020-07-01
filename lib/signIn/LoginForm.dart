class LoginForm {
  String password;
  String username;

  LoginForm(this.password, this.username);


  @override
  String toString() {
    return 'LoginForm{password: $password, username: $username}';
  }
}
