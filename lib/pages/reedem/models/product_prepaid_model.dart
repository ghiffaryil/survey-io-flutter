class ProductPrepaidCategory {
  final String category_name;
  final String product_name;
  final String image;
  final String category_image;
  final List<Product> listProducts;

  ProductPrepaidCategory({
    required this.category_name,
    required this.product_name,
    required this.image,
    required this.category_image,
    required this.listProducts,
  });
}

class Product {
  final int id;
  final String product_code;
  final String product_name;
  final int amount;
  final int price;
  final String image;
  final String category;
  final String category_image;

  Product({
    required this.id,
    required this.product_code,
    required this.product_name,
    required this.amount,
    required this.price,
    required this.category,
    required this.image,
    required this.category_image,
  });
}
