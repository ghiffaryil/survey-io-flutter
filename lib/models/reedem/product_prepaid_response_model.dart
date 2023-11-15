import 'dart:convert';

class ProductPrepaidResponseModel {
  final List<ProductPrepaidList> data;
  final int status;

  ProductPrepaidResponseModel({
    required this.data,
    required this.status,
  });

  factory ProductPrepaidResponseModel.fromJson(String str) =>
      ProductPrepaidResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductPrepaidResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductPrepaidResponseModel(
        data: List<ProductPrepaidList>.from(
            json["data"].map((x) => ProductPrepaidList.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ProductPrepaidList {
  final String productName;
  final String categoryName;
  final String categoryImage;
  final String image;
  final List<Product> products;

  ProductPrepaidList({
    required this.productName,
    required this.categoryName,
    required this.categoryImage,
    required this.image,
    required this.products,
  });

  factory ProductPrepaidList.fromJson(String str) =>
      ProductPrepaidList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductPrepaidList.fromMap(Map<String, dynamic> json) => ProductPrepaidList(
        productName: json["product_name"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        image: json["image"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "product_name": productName,
        "category_name": categoryName,
        "category_image": categoryImage,
        "image": image,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class Product {
  final int id;
  final String productCode;
  final String productName;
  final int amount;
  final int price;
  final String category;
  final String image;
  final String categoryImage;

  Product({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.amount,
    required this.price,
    required this.category,
    required this.image,
    required this.categoryImage,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        productCode: json["product_code"],
        productName: json["product_name"],
        amount: json["amount"],
        price: json["price"],
        category: json["category"],
        image: json["image"],
        categoryImage: json["category_image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_code": productCode,
        "product_name": productName,
        "amount": amount,
        "price": price,
        "category": category,
        "image": image,
        "category_image": categoryImage,
      };
}
