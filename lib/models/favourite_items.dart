class FavouriteItems {
  String categoryType;
  String productName;
  String productImage;
  int productMrp;
  int productSp;
  int productAvailability;
  String productQuantity;

  FavouriteItems({
    this.categoryType,
    this.productName,
    this.productQuantity,
    this.productAvailability,
    this.productImage,
    this.productMrp,
    this.productSp,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['favouriteId'] = productName + categoryType + productQuantity;
    map['categoryType'] = categoryType;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productMrp'] = productMrp;
    map['productSp'] = productSp;
    map['productAvailability'] = productAvailability;
    map['productQuantity'] = productQuantity;
    return map;
  }
}
