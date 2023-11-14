import 'dart:convert';

class EditProfileRequestModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String dob;
  final String gender;
  
  EditProfileRequestModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.dob,
      required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "dob": dob,
      "gender": gender,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileRequestModel.toJson(String source) =>
      EditProfileRequestModel.fromMap(json.decode(source));
}
