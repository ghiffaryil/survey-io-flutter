import 'dart:convert';

class EditProfileCompleteRequestModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String dob;
  final String gender;
  final String ktp;
  final String npwp;

  EditProfileCompleteRequestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    required this.ktp,
    required this.npwp,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "dob": dob,
      "gender": gender,
      "ktp": ktp,
      "npwp": npwp,
    };
  }

  factory EditProfileCompleteRequestModel.fromMap(Map<String, dynamic> map) {
    return EditProfileCompleteRequestModel(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      phoneNumber: map["phone_number"],
      dob: map["dob"],
      gender: map["gender"],
      ktp: map["ktp"],
      npwp: map["npwp"],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileCompleteRequestModel.toJson(String source) =>
      EditProfileCompleteRequestModel.fromMap(json.decode(source));
}
