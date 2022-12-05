class User {
   final String firstName;
   final String lastName;
   final String email;
   final String birthdate;
   final String genre;
   final String role;
   final String password;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthdate,
    required this.genre,
    required this.role,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      birthdate: json['birthdate'] as String,
      genre: json['genre'] as String,
      role: json['role'] as String,
      password: json['password'] as String,
    );
  }
  
  
}