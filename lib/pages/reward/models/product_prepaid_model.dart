class MerchantCategory {
  final String categoryName;
  final String categoryImage;
  final List<Product> products;

  MerchantCategory({
    required this.categoryName,
    required this.categoryImage,
    required this.products,
  });
}

class Product {
  final String productName;
  final int amount;
  final int price;
  final String image;
  final String categoryImage;

  Product({
    required this.productName,
    required this.amount,
    required this.price,
    required this.image,
    required this.categoryImage,
  });
}

class Merchant {
  final List<MerchantCategory> data;
  final int status;

  Merchant({
    required this.data,
    required this.status,
  });
}
