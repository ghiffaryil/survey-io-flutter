import 'dart:convert';

class VerificationOtpRequestModel {
  final String phoneNumber;
  final String otpCode;

  VerificationOtpRequestModel({
    required this.phoneNumber,
    required this.otpCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "phone_number": phoneNumber,
      "otp_code": otpCode,
    };
  }

  factory VerificationOtpRequestModel.fromMap(Map<String, dynamic> map) {
    return VerificationOtpRequestModel(
      phoneNumber: map["phone_number"],
      otpCode: map["otp_code"],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationOtpRequestModel.toJson(String source) =>
      VerificationOtpRequestModel.fromMap(json.decode(source));
}
