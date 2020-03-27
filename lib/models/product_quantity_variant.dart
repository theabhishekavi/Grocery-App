class ProductTight {
  String categoryType;
  String categoryName;
  String productName;
  String productImage;
  String productDetails;
  int productAvailability;
  int productCount;
  int productMrp;
  int productSp;
  String productQuantity;
  int productCountOrdered;
  bool productIsFav;

  ProductTight(
      {this.productCountOrdered,
      this.productIsFav,
      this.categoryType,
      this.categoryName,
      this.productName,
      this.productImage,
      this.productDetails,
      this.productAvailability,
      this.productCount,
      this.productMrp,
      this.productSp,
      this.productQuantity});
}

class ProductLoose {
  int productCountOrdered;
  bool productIsFav;
  String categoryType;
  String categoryName;
  String productName;
  String productImage;
  String productDetails;
  List<ProductQuantityVariants> productQuantity;

  ProductLoose(
      {this.productCountOrdered,
      this.productIsFav,
      this.categoryType,
      this.categoryName,
      this.productName,
      this.productImage,
      this.productDetails,
      this.productQuantity});
}

class ProductQuantityVariants {
  int productAvailability;
  int productCount;
  int productMrp;
  int productSp;
  String productQuantity;

  ProductQuantityVariants(
      {this.productAvailability,
      this.productCount,
      this.productMrp,
      this.productSp,
      this.productQuantity});
}
