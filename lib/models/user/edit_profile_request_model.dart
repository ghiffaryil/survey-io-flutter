import 'dart:convert';

class EditProfileRequestModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String dob;
  final String gender;
  String? province;
  String? city;
  String? ktp;
  String? npwp;

  EditProfileRequestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    required this.ktp,
    required this.npwp,
    required this.province,
    required this.city,
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
      "province": province,
      "city": city,
    };
  }

  factory EditProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return EditProfileRequestModel(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      phoneNumber: map["phone_number"],
      dob: map["dob"],
      gender: map["gender"],
      ktp: map["ktp"],
      npwp: map["npwp"],
      province: map["province"],
      city: map["city"],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileRequestModel.toJson(String source) =>
      EditProfileRequestModel.fromMap(json.decode(source));
}
