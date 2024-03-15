class SignRequest {
  final String email;
  final String password;

  SignRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}
