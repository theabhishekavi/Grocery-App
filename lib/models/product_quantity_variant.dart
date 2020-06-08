class ProductTight {
  String categoryType;
  String categoryName;
  String productName;
  String productImage;
  String productImage2;
  String productImage3;
  String productDetails;
  int productAvailability;
  int productCount;
  int productMrp;
  int productSp;
  String productQuantity;
  int productCountOrdered;
  bool productIsFav;
  int productOfferQuantity;
  int productOfferDiscountPercentage;
  int productOfferDiscountRupees;

  ProductTight({
    this.productCountOrdered,
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
    this.productQuantity,
    this.productImage2,
    this.productImage3,
    this.productOfferQuantity,
    this.productOfferDiscountPercentage,
    this.productOfferDiscountRupees,
  });
}

// class ProductLoose {
//   int productCountOrdered;
//   bool productIsFav;
//   String categoryType;
//   String categoryName;
//   String productName;
//   String productImage;
//   String productDetails;
//   List<ProductQuantityVariants> productQuantity;

//   ProductLoose(
//       {this.productCountOrdered,
//       this.productIsFav,
//       this.categoryType,
//       this.categoryName,
//       this.productName,
//       this.productImage,
//       this.productDetails,
//       this.productQuantity});
// }

// class ProductQuantityVariants {
//   int productAvailability;
//   int productCount;
//   int productMrp;
//   int productSp;
//   String productQuantity;

//   ProductQuantityVariants(
//       {this.productAvailability,
//       this.productCount,
//       this.productMrp,
//       this.productSp,
//       this.productQuantity});
// }
