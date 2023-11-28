import 'dart:convert';

class VerificationOtpResponseModel {
  final Data data;
  final String message;
  final int status;

  VerificationOtpResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory VerificationOtpResponseModel.fromJson(String str) =>
      VerificationOtpResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerificationOtpResponseModel.fromMap(Map<String, dynamic> json) =>
      VerificationOtpResponseModel(
        data: Data.fromMap(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "message": message,
        "status": status,
      };
}

class Data {
  final int id;
  final String phoneNumber;
  final String otpCode;
  final int verifyRequest;
  final int status;
  final DateTime datetimeCreated;
  final DateTime datetimeUpdated;

  Data({
    required this.id,
    required this.phoneNumber,
    required this.otpCode,
    required this.verifyRequest,
    required this.status,
    required this.datetimeCreated,
    required this.datetimeUpdated,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        phoneNumber: json["phone_number"],
        otpCode: json["otp_code"],
        verifyRequest: json["verify_request"],
        status: json["status"],
        datetimeCreated: DateTime.parse(json["datetime_created"]),
        datetimeUpdated: DateTime.parse(json["datetime_updated"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "phone_number": phoneNumber,
        "otp_code": otpCode,
        "verify_request": verifyRequest,
        "status": status,
        "datetime_created": datetimeCreated.toIso8601String(),
        "datetime_updated": datetimeUpdated.toIso8601String(),
      };
}
