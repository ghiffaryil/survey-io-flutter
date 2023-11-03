import 'dart:convert';

class ProfileResponseModel {
  final Data data;
  final int status;

  ProfileResponseModel({
    required this.data,
    required this.status,
  });

  factory ProfileResponseModel.fromJson(String str) =>
      ProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      ProfileResponseModel(
        data: Data.fromMap(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "status": status,
      };
}

class Data {
  final int point;
  final User user;
  final UserProfile userProfile;

  Data({
    required this.point,
    required this.user,
    required this.userProfile,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        point: json["point"],
        user: User.fromMap(json["user"]),
        userProfile: UserProfile.fromMap(json["user_profile"]),
      );

  Map<String, dynamic> toMap() => {
        "point": point,
        "user": user.toMap(),
        "user_profile": userProfile.toMap(),
      };
}

class User {
  final int id;
  final String name;
  final String email;
  final int emailVerified;
  final int active;
  final String phoneNumber;
  final String provider;
  final String refcode;
  final String platform;
  final String firebaseToken;
  final DateTime datetimeCreated;
  final DateTime datetimeUpdated;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.active,
    required this.phoneNumber,
    required this.provider,
    required this.refcode,
    required this.platform,
    required this.firebaseToken,
    required this.datetimeCreated,
    required this.datetimeUpdated,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"] ?? "",
        emailVerified:
            json["email_verified"] ?? 0, // Provide a default value if it's null
        active: json["active"] ?? 0, // Provide a default value if it's null
        refcode: json["refcode"] ?? "",
        platform: json["platform"] ?? "",
        phoneNumber: json["phone_number"],
        provider: json["provider"],
        firebaseToken: json["firebase_token"],
        datetimeCreated: DateTime.parse(json["datetime_created"]),
        datetimeUpdated: DateTime.parse(json["datetime_updated"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified": emailVerified,
        "active": active,
        "phone_number": phoneNumber,
        "provider": provider,
        "refcode": refcode,
        "platform": platform,
        "firebase_token": firebaseToken,
        "datetime_created": datetimeCreated.toIso8601String(),
        "datetime_updated": datetimeUpdated.toIso8601String(),
      };
}

class UserProfile {
  final int id;
  final int userId;
  final String ktp;
  final dynamic npwp;
  final DateTime dob;
  final int age;
  final dynamic children;
  final dynamic region;
  final String gender;
  final dynamic province;
  final dynamic city;
  final dynamic ethnic;
  final String religion;
  final dynamic education;
  final dynamic marital;
  final dynamic occupation;
  final int monthlyIncome;
  final dynamic monthlyOutcome;

  UserProfile({
    required this.id,
    required this.userId,
    required this.ktp,
    required this.npwp,
    required this.dob,
    required this.age,
    required this.children,
    required this.region,
    required this.gender,
    required this.province,
    required this.city,
    required this.ethnic,
    required this.religion,
    required this.education,
    required this.marital,
    required this.occupation,
    required this.monthlyIncome,
    required this.monthlyOutcome,
  });

  factory UserProfile.fromJson(String str) =>
      UserProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        userId: json["user_id"],
        ktp: json["ktp"] as String? ?? "",
        npwp: json["npwp"] as String? ?? "",
        dob: json["dob"] != null
            ? DateTime.parse(json["dob"])
            : DateTime.now(), // Provide a default value when dob is null
        age: json["age"] ?? 0, // Provide a default value when age is null
        children: json["children"],
        region: json["region"],
        gender: json["gender"] as String? ?? "",
        province: json["province"] as String? ?? "",
        city: json["city"] as String? ?? "",
        ethnic: json["ethnic"] as String? ?? "",
        religion: json["religion"] as String? ?? "",
        education: json["education"] as String? ?? "",
        marital: json["marital"] as String? ?? "",
        occupation: json["occupation"] as String? ?? "",
        monthlyIncome: json["monthly_income"] ??
            0, // Provide a default value when monthly_income is null
        monthlyOutcome: json["monthly_outcome"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "ktp": ktp,
        "npwp": npwp,
        "dob": dob.toIso8601String(),
        "age": age,
        "children": children,
        "region": region,
        "gender": gender,
        "province": province,
        "city": city,
        "ethnic": ethnic,
        "religion": religion,
        "education": education,
        "marital": marital,
        "occupation": occupation,
        "monthly_income": monthlyIncome,
        "monthly_outcome": monthlyOutcome,
      };
}
