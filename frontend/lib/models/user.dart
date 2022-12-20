class User {
  final String firstName;
  final String lastName;
  final String email;
  final String birthdate;
  final int genre;
  final int role;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthdate,
    required this.genre,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      birthdate: json['birthdate'] as String,
      genre: json['genre'] as int,
      role: json['role'] as int,
    );
  }
}
