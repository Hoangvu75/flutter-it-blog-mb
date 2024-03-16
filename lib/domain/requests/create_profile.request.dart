class CreateProfileRequest {
  final String firstName;
  final String lastName;
  final int dateOfBirth;
  final String phone;
  final String address;
  final String gender;

  CreateProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phone,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "phone": phone,
      "address": address,
      "gender": gender,
    };
  }
}