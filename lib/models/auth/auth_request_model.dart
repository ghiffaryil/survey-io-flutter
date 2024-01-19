import 'dart:convert';

class AuthRequestModel {
  String phoneNumber;
  String email;
  final String pin;
  final String firebaseToken;
  final String platform;
  final String deviceId;

  // Constructor for phone number-based authentication
  AuthRequestModel.withPhoneNumber({
    required this.phoneNumber,
    required this.pin,
    required this.firebaseToken,
    required this.platform,
    required this.deviceId,
  }) : email = '';

  // Constructor for email-based authentication
  AuthRequestModel.withEmail({
    required this.email,
    required this.pin,
    required this.firebaseToken,
    required this.platform,
    required this.deviceId,
  }) : phoneNumber = '';

  Map<String, dynamic> toMap() {
    return {
      'phone_number': phoneNumber,
      'email': email,
      'pin': pin,
      'firebase_token': firebaseToken,
      'platform': platform,
      'device_id': deviceId,
    };
  }

  // factory AuthRequestModel.fromMap(Map<String, dynamic> map) {
  //   return AuthRequestModel.withPhoneNumber(
  //     phoneNumber: map['phone_number'] ?? '',
  //     pin: map['pin'] ?? '',
  //     firebaseToken: map['firebaseToken'] ?? '',
  //     platform: map['platform'] ?? '',
  //     deviceId: map['deviceId'] ?? '',
  //   );
  // }

  factory AuthRequestModel.fromMap(Map<String, dynamic> map) {
    final phoneNumber = map['phone_number'] as String?;
    final email = map['email'] as String?;
    final pin = map['pin'] as String? ?? '';
    final firebaseToken = map['firebase_token'] as String? ?? '';
    final platform = map['platform'] as String? ?? '';
    final deviceId = map['device_id'] as String? ?? '';

    if (phoneNumber == null && email == null) {
      // Throw an exception or handle the case where neither phone number nor email is provided
      throw Exception('Either phone number or email must be provided.');
    }

    // Check if both phone number and email are provided, and throw an exception if so
    if (phoneNumber != null && email != null) {
      throw Exception('Provide either phone number or email, not both.');
    }

    if (phoneNumber != null) {
      // Return an instance with phone number-based authentication
      return AuthRequestModel.withPhoneNumber(
        phoneNumber: phoneNumber,
        pin: pin,
        firebaseToken: firebaseToken,
        platform: platform,
        deviceId: deviceId,
      );
    } else {
      // Return an instance with email-based authentication
      return AuthRequestModel.withEmail(
        email: email!,
        pin: pin,
        firebaseToken: firebaseToken,
        platform: platform,
        deviceId: deviceId,
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory AuthRequestModel.fromJson(String source) =>
      AuthRequestModel.fromMap(json.decode(source));
}
