class ProductModel {
  final String productImage;
  final String productName;
  final int productMrp;
  final int productSp;
  final int productAvailability;
  final String productQuantity;
  int productCountOrdered;

  ProductModel({
    this.productName,
    this.productMrp,
    this.productQuantity,
    this.productImage,
    this.productAvailability,
    this.productSp,
    this.productCountOrdered
  });
}
