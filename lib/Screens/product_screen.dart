import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop/Screens/product_detail_screen.dart';
import 'package:shop/database/favourite_helper.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/models/favourite_items.dart';
import 'package:shop/models/product_quantity_variant.dart';
import 'package:shop/models/product_type.dart';
import '../database/cartTable_helper.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/ProductScreen';
  String categoryType = "";
  String categoryName = "";
  ProductScreen({this.categoryType, this.categoryName});

  ProductScreen.fromType({this.categoryType}); //i think this is unnecessary

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  CartTableHelper cartDatabaseHelper = CartTableHelper();
  FavouriteHelper favouriteHelper = FavouriteHelper();
  List<CartItems> cartItemList = [];
  List<FavouriteItems> favItemList = [];
  List<dynamic> productList = [
    // ProductModel(
    //     productName: 'Bread',
    //     productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //     productAvailability: 100,
    //     productSp: 27,
    //     productCountOrdered: 0,
    //     productIsFav: false,
    //     productMrp: 27,
    //     productQuantity: '1'),
    // ProductModel(
    //     productName: 'Jam',
    //     productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //     productAvailability: 100,
    //     productSp: 27,
    //     productCountOrdered: 0,
    //     productIsFav: false,
    //     productMrp: 30,
    //     productQuantity: '1'),
    // ProductModel(
    //     productName: 'Toast',
    //     productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //     productAvailability: 100,
    //     productSp: 27,
    //     productCountOrdered: 0,
    //     productIsFav: false,
    //     productMrp: 30,
    //     productQuantity: '1'),
    // ProductModel(
    //     productName: 'Pav',
    //     productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //     productAvailability: 100,
    //     productSp: 27,
    //     productCountOrdered: 0,
    //     productIsFav: false,
    //     productMrp: 30,
    //     productQuantity: '1'),
    // ProductModel(
    //     productName: 'Butter',
    //     productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //     productAvailability: 100,
    //     productSp: 27,
    //     productCountOrdered: 0,
    //     productIsFav: false,
    //     productMrp: 30,
    //     productQuantity: '1'),
  ];
  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  Future<void> getAllData() async {
    await getFirebaseData();
    cartItemList = [];
    List<Map<String, dynamic>> list = await cartDatabaseHelper.getCartMapList();
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> map = list[i];
      CartItems x = new CartItems(
        pName: map['pName'],
        pCategoryName: map['pCategoryName'],
        pCountOrdered: int.parse(map['pCountOrdered']),
        pImage: map['pImage'],
        pMrp: int.parse(map['pMrp']),
        pQuantity: map['pQuantity'],
        pSp: int.parse(map['pSp']),
        pAvailability: int.parse(map['pAvailability']),
      );
      if (!cartItemList.contains(x)) cartItemList.add(x);
    }

    favItemList = [];
    List<Map<String, dynamic>> favlist =
        await favouriteHelper.getFavouriteMapList();
    for (int i = 0; i < favlist.length; i++) {
      Map<String, dynamic> map = favlist[i];
      FavouriteItems x = new FavouriteItems(
        categoryType: map['categoryType'],
        productName: map['productName'],
        productQuantity: map['productQuantity'],
        productAvailability: int.parse(map['productAvailability']),
        productImage: map['productImage'],
        productMrp: int.parse(map['productMrp']),
        productSp: int.parse(map['productSp']),
      );
      if (!favItemList.contains(x)) favItemList.add(x);
    }
  }

  var favCheck = false;

  bool loadDataFromFirebase = false;

  @override
  void initState() {
    super.initState();

    getAllData().then((_) {
      if (this.mounted) {
        setState(() {
          productList.sort((one, two) {
            return one.productName.compareTo(two.productName);
          });
          loadDataFromFirebase = true;
          cartItemList = cartItemList;
          favItemList = favItemList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = Container(
      width: 120,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryType),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: (widget.categoryName == null)
                  ? Text(
                      '${widget.categoryType}(All Sub Categories)',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  : Text(
                      widget.categoryName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
            ),
          ),
          (loadDataFromFirebase == false)
              ? Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: loadingIndicator,
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (ctx, index) {
                        getpCountOrderedFromDatabase(index);
                        getFavouriteItemsFromDatabase(index, favCheck);
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (_) {
                                          return ProductDetailScreen(
                                            productTight: productList[index],
                                            productTightList: productList,
                                          );
                                        }));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            height: 60,
                                            child: Image.network(
                                              productList[index].productImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  productList[index]
                                                      .productName,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                        'Rs ${productList[index].productSp}'),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    (productList[index]
                                                                .productMrp !=
                                                            productList[index]
                                                                .productSp)
                                                        ? Row(
                                                            children: <Widget>[
                                                              Text(
                                                                '${productList[index].productMrp}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${discountPer(productList[index].productMrp, productList[index].productSp)}% off',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ],
                                                          )
                                                        : Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                          ),
                                                  ],
                                                ),
                                                Text(
                                                    'Quantity : ${productList[index].productQuantity}'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                favCheck = true;
                                                if (productList[index]
                                                    .productIsFav) {
                                                  _deleteFav(productList[index]
                                                          .productName +
                                                      productList[index]
                                                          .categoryType +
                                                      productList[index]
                                                          .productQuantity);
                                                } else {
                                                  _insertFav(
                                                    FavouriteItems(
                                                      categoryType:
                                                          productList[index]
                                                              .categoryType,
                                                      productName:
                                                          productList[index]
                                                              .productName,
                                                      productQuantity:
                                                          productList[index]
                                                              .productQuantity,
                                                      productAvailability:
                                                          productList[index]
                                                              .productAvailability,
                                                      productImage:
                                                          productList[index]
                                                              .productImage,
                                                      productMrp:
                                                          productList[index]
                                                              .productMrp,
                                                      productSp:
                                                          productList[index]
                                                              .productSp,
                                                    ),
                                                  );
                                                }
                                                productList[index]
                                                        .productIsFav =
                                                    !productList[index]
                                                        .productIsFav;
                                              });
                                            },
                                            child: Icon(
                                              (productList[index].productIsFav)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                          (productList[index]
                                                      .productCountOrdered >
                                                  0)
                                              ? Container(
                                                  child: (productList[index]
                                                              .productCountOrdered ==
                                                          1)
                                                      ? Text(
                                                          '${productList[index].productCountOrdered} Item in Cart',
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                          textAlign:
                                                              TextAlign.end,
                                                        )
                                                      : Text(
                                                          '${productList[index].productCountOrdered} Item(s) in Cart',
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    //   Container(
                                    //     decoration: BoxDecoration(
                                    //       shape: BoxShape.rectangle,
                                    //       border: Border.all(
                                    //         color: Theme.of(context).accentColor,
                                    //         width: 1.0,
                                    //       ),
                                    //     ),
                                    //     width: 80,
                                    //     height: 35,
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceAround,
                                    //       children: <Widget>[
                                    //         InkWell(
                                    //           onTap: () {
                                    //             if (productList[index]
                                    //                     .productCountOrdered >
                                    //                 0) {
                                    //               CartItems x = new CartItems(
                                    //                 pImage: productList[index]
                                    //                     .productImage,
                                    //                 pName: productList[index]
                                    //                     .productName,
                                    //                 pCountOrdered: productList[
                                    //                             index]
                                    //                         .productCountOrdered -
                                    //                     1,
                                    //                 pCategoryName:
                                    //                     (widget.categoryName !=
                                    //                             "")
                                    //                         ? widget.categoryName
                                    //                         : widget.categoryType,
                                    //                 pMrp: productList[index]
                                    //                     .productMrp,
                                    //                 pSp: productList[index]
                                    //                     .productSp,
                                    //                 pQuantity: productList[index]
                                    //                     .productQuantity,
                                    //                 pAvailability:
                                    //                     productList[index]
                                    //                         .productAvailability,
                                    //               );
                                    //               if (productList[index]
                                    //                       .productCountOrdered ==
                                    //                   1) {
                                    //                 _deleteCart(productList[index]
                                    //                             .productName +
                                    //                         productList[index]
                                    //                             .productQuantity)
                                    //                     .then((_) {
                                    //                   setState(() {
                                    //                     check = true;
                                    //                     productList[index]
                                    //                         .productCountOrdered--;
                                    //                   });
                                    //                 });
                                    //               } else {
                                    //                 _updateCart(x).then((_) {
                                    //                   setState(() {
                                    //                     check = true;
                                    //                     productList[index]
                                    //                         .productCountOrdered--;
                                    //                   });
                                    //                 });
                                    //               }
                                    //             }
                                    //           },
                                    //           child: Icon(
                                    //             Icons.remove,
                                    //             size: 18,
                                    //             color:
                                    //                 Theme.of(context).accentColor,
                                    //           ),
                                    //         ),
                                    //         VerticalDivider(
                                    //           width: 10,
                                    //           thickness: 1,
                                    //           color:
                                    //               Theme.of(context).accentColor,
                                    //         ),
                                    //         Text(
                                    //           '${productList[index].productCountOrdered}',
                                    //           style: TextStyle(
                                    //             fontSize: 13,
                                    //           ),
                                    //         ),
                                    //         VerticalDivider(
                                    //           width: 10,
                                    //           thickness: 1,
                                    //           color:
                                    //               Theme.of(context).accentColor,
                                    //         ),
                                    //         InkWell(
                                    //           onTap: () {
                                    //             if (productList[index]
                                    //                     .productCountOrdered <
                                    //                 5) {
                                    //               CartItems x = new CartItems(
                                    //                 pImage: productList[index]
                                    //                     .productImage,
                                    //                 pName: productList[index]
                                    //                     .productName,
                                    //                 pCountOrdered: productList[
                                    //                             index]
                                    //                         .productCountOrdered +
                                    //                     1,
                                    //                 pCategoryName:
                                    //                     (widget.categoryName !=
                                    //                             "")
                                    //                         ? widget.categoryName
                                    //                         : widget.categoryType,
                                    //                 pMrp: productList[index]
                                    //                     .productMrp,
                                    //                 pSp: productList[index]
                                    //                     .productSp,
                                    //                 pQuantity: productList[index]
                                    //                     .productQuantity,
                                    //                 pAvailability:
                                    //                     productList[index]
                                    //                         .productAvailability,
                                    //               );
                                    //               if (productList[index]
                                    //                       .productCountOrdered ==
                                    //                   0) {
                                    //                 _insertCart(x).then((_) {
                                    //                   setState(() {
                                    //                     check = true;
                                    //                     productList[index]
                                    //                             .productCountOrdered =
                                    //                         productList[index]
                                    //                                 .productCountOrdered +
                                    //                             1;
                                    //                   });
                                    //                 });
                                    //               } else {
                                    //                 _updateCart(x).then((_) {
                                    //                   setState(() {
                                    //                     check = true;
                                    //                     productList[index]
                                    //                             .productCountOrdered =
                                    //                         productList[index]
                                    //                                 .productCountOrdered +
                                    //                             1;
                                    //                   });
                                    //                 });
                                    //               }
                                    //             }
                                    //           },
                                    //           child: Icon(
                                    //             Icons.add,
                                    //             size: 18,
                                    //             color:
                                    //                 Theme.of(context).accentColor,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      }),
                )
        ],
      ),
    );
  }

  Future<void> _insertCart(CartItems cartItems) async {
    await cartDatabaseHelper.insertCartItem(cartItems);
  }

  Future<void> _updateCart(CartItems cartItems) async {
    await cartDatabaseHelper.updateCart(cartItems);
  }

  Future<void> _deleteCart(String id) async {
    await cartDatabaseHelper.deleteCartItem(id);
  }

  Future<void> _insertFav(FavouriteItems favouriteItems) async {
    await favouriteHelper.insertFavouriteItem(favouriteItems);
  }

  Future<void> _deleteFav(String id) async {
    await favouriteHelper.deleteFavouriteItem(id);
  }

  void getpCountOrderedFromDatabase(int index) {
    for (int j = 0; j < cartItemList.length; j++) {
      if (cartItemList[j].pName == productList[index].productName &&
          cartItemList[j].pQuantity == productList[index].productQuantity &&
          cartItemList[j].pMrp == productList[index].productMrp) {
        productList[index].productCountOrdered = cartItemList[j].pCountOrdered;
      }
    }
  }

  void getFavouriteItemsFromDatabase(int index, bool favCheck) {
    if (!favCheck) {
      for (int j = 0; j < favItemList.length; j++) {
        if (favItemList[j].productName == productList[index].productName &&
            favItemList[j].productQuantity ==
                productList[index].productQuantity) {
          productList[index].productIsFav = true;
        }
      }
    }
  }

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  Future<void> getFirebaseData() async {
    String catTypeName;
    String categoryName;
    String productName, productImage, productDetails, productQuantity;
    int productMrp, productSp, productAvailability, productCount;
    await databaseReference
        .child('categories')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((catTypeKey, catTypevalue) {
        catTypeName = catTypeKey;
        if (catTypeName == widget.categoryType) {
          if (widget.categoryName == null) {
            for (int j = 1; j <= 4; j++) {
              Map<dynamic, dynamic> val1 = catTypevalue['$j'];
              categoryName = val1['category_name'];
              List<dynamic> productval1 = val1['products'];
              for (int i = 1; i < productval1.length; i++) {
                productName = productval1[i]['product_name'];
                productImage = productval1[i]['product_image'];
                productDetails = productval1[i]['product_details'];
                if (productval1[i]['product_quantity'] is String) {
                  productSp = productval1[i]['product_sp'];
                  productQuantity = productval1[i]['product_quantity'];
                  productMrp = productval1[i]['product_mrp'];
                  productAvailability = productval1[i]['product_availability'];
                  productCount = productval1[i]['product_count'];
                  ProductTight productTight = ProductTight(
                    categoryType: catTypeName,
                    categoryName: categoryName,
                    productName: productName,
                    productImage: productImage,
                    productDetails: productDetails,
                    productSp: productSp,
                    productQuantity: productQuantity,
                    productMrp: productMrp,
                    productCountOrdered: 0,
                    productIsFav: false,
                    productAvailability: productAvailability,
                    productCount: productCount,
                  );
                  productList.add(productTight);
                } else {
                  List<dynamic> quantityVariants =
                      productval1[i]['product_quantity'];
                  print(quantityVariants.length);
                  List<ProductQuantityVariants> productQuantityVariantsList =
                      [];
                  for (int j = 1; j < quantityVariants.length; j++) {
                    ProductQuantityVariants productQuantityVariants =
                        ProductQuantityVariants(
                            productAvailability: quantityVariants[j]
                                ['product_availability'],
                            productCount: quantityVariants[j]['product_count'],
                            productMrp: quantityVariants[j]['product_mrp'],
                            productQuantity: quantityVariants[j]
                                ['product_quantity'],
                            productSp: quantityVariants[j]['product_sp']);
                    productQuantityVariantsList.add(productQuantityVariants);
                  }
                  ProductLoose productLoose = ProductLoose(
                    categoryType: catTypeName,
                    categoryName: categoryName,
                    productDetails: productDetails,
                    productImage: productImage,
                    productName: productName,
                    productQuantity: productQuantityVariantsList,
                  );
                  // productList.add(productLoose);
                }
              }
            } //j
          } //categoryName == null i.e,.categories screen
          if (widget.categoryName != null) {
            for (int j = 1; j <= 4; j++) {
              if (catTypevalue['$j']['category_name'] == widget.categoryName) {
                Map<dynamic, dynamic> val1 = catTypevalue['$j'];
                categoryName = val1['category_name'];

                List<dynamic> productval1 = val1['products'];
                for (int i = 1; i < productval1.length; i++) {
                  if(productval1[i]!=null){
                    productName = productval1[i]['product_name'];
                  productImage = productval1[i]['product_image'];
                  productDetails = productval1[i]['product_details'];
                  if (productval1[i]['product_quantity'] is String) {
                    productSp = productval1[i]['product_sp'];
                    productQuantity = productval1[i]['product_quantity'];
                    productMrp = productval1[i]['product_mrp'];
                    productAvailability =
                        productval1[i]['product_availability'];
                    productCount = productval1[i]['product_count'];
                    ProductTight productTight = ProductTight(
                      categoryType: catTypeName,
                      categoryName: categoryName,
                      productName: productName,
                      productImage: productImage,
                      productDetails: productDetails,
                      productSp: productSp,
                      productQuantity: productQuantity,
                      productMrp: productMrp,
                      productCountOrdered: 0,
                      productIsFav: false,
                      productAvailability: productAvailability,
                      productCount: productCount,
                    );
                    productList.add(productTight);
                  } else {
                    List<dynamic> quantityVariants =
                        productval1[i]['product_quantity'];
                    print(quantityVariants.length);
                    List<ProductQuantityVariants> productQuantityVariantsList =
                        [];
                    for (int j = 1; j < quantityVariants.length; j++) {
                      ProductQuantityVariants productQuantityVariants =
                          ProductQuantityVariants(
                              productAvailability: quantityVariants[j]
                                  ['product_availability'],
                              productCount: quantityVariants[j]
                                  ['product_count'],
                              productMrp: quantityVariants[j]['product_mrp'],
                              productQuantity: quantityVariants[j]
                                  ['product_quantity'],
                              productSp: quantityVariants[j]['product_sp']);
                      productQuantityVariantsList.add(productQuantityVariants);
                    }
                    ProductLoose productLoose = ProductLoose(
                      categoryType: catTypeName,
                      categoryName: categoryName,
                      productDetails: productDetails,
                      productImage: productImage,
                      productName: productName,
                      productQuantity: productQuantityVariantsList,
                    );
                    // productList.add(productLoose);
                  }
                  }
                  
                }
              }
            }
          }

          // Map<dynamic, dynamic> val2 = catTypevalue['2'];
          // category2Name = val2['category_name'];
          // print(category2Name);
          // category2Image = val2['category_image'];
          // List<dynamic> productval2 = val2['products'];
          // for (int i = 1; i < productval2.length; i++) {
          //   productName = productval2[i]['product_name'];
          //   productImage = productval2[i]['product_image'];
          //   productDetails = productval2[i]['product_details'];

          //   if (productval2[i]['product_quantity'] is String) {
          //     productQuantity = productval2[i]['product_quantity'];
          //     productMrp = productval2[i]['product_mrp'];
          //     productSp = productval2[i]['product_sp'];
          //     productAvailability = productval2[i]['product_availability'];
          //     productCount = productval2[i]['product_count'];
          //   } else {}
          // }

          // Map<dynamic, dynamic> val3 = catTypevalue['3'];
          // category3Name = val3['category_name'];
          // print(category3Name);
          // category3Image = val3['category_image'];
          // List<dynamic> productval3 = val3['products'];
          // for (int i = 1; i < productval3.length; i++) {
          //   productName = productval3[i]['product_name'];
          //   productImage = productval3[i]['product_image'];
          //   productDetails = productval3[i]['product_details'];

          //   if (productval3[i]['product_quantity'] is String) {
          //     productSp = productval3[i]['product_sp'];
          //     productQuantity = productval3[i]['product_quantity'];
          //     productMrp = productval3[i]['product_mrp'];
          //     productAvailability = productval3[i]['product_availability'];
          //     productCount = productval3[i]['product_count'];
          //   } else {}
          // }

          // Map<dynamic, dynamic> val4 = catTypevalue['4'];
          // category4Name = val4['category_name'];
          // print(category4Name);
          // category4Image = val4['category_image'];
          // List<dynamic> productval4 = val4['products'];
          // for (int i = 1; i < productval4.length; i++) {
          //   productName = productval4[i]['product_name'];
          //   productImage = productval4[i]['product_image'];
          //   productDetails = productval4[i]['product_details'];

          //   if (productval4[i]['product_quantity'] is String) {
          //     ;
          //     productSp = productval4[i]['product_sp'];
          //     productQuantity = productval4[i]['product_quantity'];
          //     productMrp = productval4[i]['product_mrp'];
          //     productAvailability = productval4[i]['product_availability'];
          //     productCount = productval4[i]['product_count'];
          //   } else {}

          //   if (productSp == null ||
          //       productName == null ||
          //       productImage == null ||
          //       productQuantity == null ||
          //       productMrp == null ||
          //       productAvailability == null ||
          //       productCount == null)
          //     print(
          //         '$i $productSp $productName $productImage $productQuantity $productMrp $productAvailability $productCount');
          // }
        }
      });
    });
  }
}
