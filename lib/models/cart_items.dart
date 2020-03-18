class CartItems {
  final String pImage;
  final String pName;
  final String pQuantity;
  final int pMrp;
  final int pSp;
  int pCountOrdered;
  final String pCategoryName;
  final int pAvailability;

  CartItems(
      {this.pImage,
      this.pCountOrdered,
      this.pMrp,
      this.pName,
      this.pQuantity,
      this.pSp,
      this.pCategoryName,
      this.pAvailability});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['pId'] = pName + pQuantity;
    map['pImage'] = pImage;
    map['pCountOrdered'] = pCountOrdered;
    map['pMrp'] = pMrp;
    map['pSp'] = pSp;
    map['pName'] = pName;
    map['pQuantity'] = pQuantity;
    map['pCategoryName'] = pCategoryName;
    map['pAvailability'] = pAvailability;
    return map;
  }
}
