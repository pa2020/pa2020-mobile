class UserDto {
  int id;
  String email;
  String firstName;
  String lastName;
  String password;
  List<String> role;
  String username;

  UserDto(this.email, this.firstName, this.lastName, this.password,
      this.role, this.username);

  @override
  String toString() {
    return 'UserDto{email: $email, firstname: $firstName, lastname: $lastName, password: $password, role: $role, username: $username}';
  }

  UserDto.withId(
      this.id, this.email, this.firstName, this.lastName, this.username);

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(json["email"], json["firstname"], json["lastname"],
        json["password"], json["role"], json["username"]);
  }
}
