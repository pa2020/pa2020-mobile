class RegisterDto {
  String email;
  String firstName;
  String lastName;
  String password1;
  String password2;
  String role;
  String username;

  RegisterDto(this.email, this.firstName, this.lastName, this.password1,
      this.password2, this.role, this.username);

  @override
  String toString() {
    return 'RegisterDto{email: $email, firstname: $firstName, lastname: $lastName, password1: $password1, password2: $password2, role: $role, username: $username}';
  }
}
