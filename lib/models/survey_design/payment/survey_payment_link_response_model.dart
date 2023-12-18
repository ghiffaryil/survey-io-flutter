import 'dart:convert';

class SurveyPaymentLinkResponseModel {
  final Data data;
  final String message;
  final int status;

  SurveyPaymentLinkResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SurveyPaymentLinkResponseModel.fromJson(String str) =>
      SurveyPaymentLinkResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyPaymentLinkResponseModel.fromMap(Map<String, dynamic> json) =>
      SurveyPaymentLinkResponseModel(
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
  final bool status;
  final String url;
  final String message;
  final String emailStatus;
  final String paymentLinkId;
  final String childBalance;

  Data({
    required this.status,
    required this.url,
    required this.message,
    required this.emailStatus,
    required this.paymentLinkId,
    required this.childBalance,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        status: json["status"],
        url: json["url"],
        message: json["message"],
        emailStatus: json["email_status"],
        paymentLinkId: json["payment_link_id"],
        childBalance: json["child_balance"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "url": url,
        "message": message,
        "email_status": emailStatus,
        "payment_link_id": paymentLinkId,
        "child_balance": childBalance,
      };
}
