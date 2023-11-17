import 'dart:convert';

class TopUpPrepaidResponseModel {
  final Data data;
  final String message;
  final int status;

  TopUpPrepaidResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory TopUpPrepaidResponseModel.fromJson(String str) =>
      TopUpPrepaidResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopUpPrepaidResponseModel.fromMap(Map<String, dynamic> json) =>
      TopUpPrepaidResponseModel(
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
  final String refId;
  final int status;
  final String productCode;
  final String customerId;
  final int price;
  final int balance;
  final String message;
  final int trId;
  final String rc;
  final dynamic errorDetails;

  Data({
    required this.refId,
    required this.status,
    required this.productCode,
    required this.customerId,
    required this.price,
    required this.balance,
    required this.message,
    required this.trId,
    required this.rc,
    required this.errorDetails,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        refId: json["ref_id"],
        status: json["status"],
        productCode: json["product_code"],
        customerId: json["customer_id"],
        price: json["price"],
        balance: json["balance"],
        message: json["message"],
        trId: json["tr_id"],
        rc: json["rc"],
        errorDetails: json["error_details"],
      );

  Map<String, dynamic> toMap() => {
        "ref_id": refId,
        "status": status,
        "product_code": productCode,
        "customer_id": customerId,
        "price": price,
        "balance": balance,
        "message": message,
        "tr_id": trId,
        "rc": rc,
        "error_details": errorDetails,
      };
}
