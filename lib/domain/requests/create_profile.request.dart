class CreateProfileRequest {
  final String firstName;
  final String lastName;
  final int dateOfBirth;
  final String phone;
  final String address;
  final String gender;
  final String job;
  final String company;

  CreateProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phone,
    required this.address,
    required this.gender,
    required this.job,
    required this.company,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "phone": phone,
      "address": address,
      "gender": gender,
      "job": job,
      "company": company,
    };
  }
}