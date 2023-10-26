class ProductPrepaidCategory {
  final String categoryName;
  final String productName;
  final String image;
  final String categoryImage;
  final List<Product> listProducts;

  ProductPrepaidCategory({
    required this.categoryName,
    required this.productName,
    required this.image,
    required this.categoryImage,
    required this.listProducts,
  });
}

class Product {
  final int id;
  final String productCode;
  final String productName;
  final int amount;
  final int price;
  final String image;
  final String category;
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
}
