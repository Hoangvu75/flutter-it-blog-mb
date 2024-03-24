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

  factory GoogleSignInRequest.fromMap(Map<String, dynamic> map) {
    return GoogleSignInRequest(
      email: map['email'],
    );
  }
}
