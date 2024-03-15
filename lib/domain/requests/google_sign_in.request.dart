class GoogleSignInRequest {
  final String email;

  GoogleSignInRequest({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
    };
  }
}
