import 'package:flutter/material.dart';
import 'package:shop/Screens/product_detail_screen.dart';
import 'package:shop/database/favourite_helper.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/models/favourite_items.dart';
import 'package:shop/models/product_type.dart';
import '../database/cartTable_helper.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/ProductScreen';
  String categoryType = "";
  String categoryName = "";
  ProductScreen({this.categoryType, this.categoryName});

  ProductScreen.fromType({this.categoryType});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  CartTableHelper cartDatabaseHelper = CartTableHelper();
  FavouriteHelper favouriteHelper = FavouriteHelper();
  List<CartItems> cartItemList = [];
  List<FavouriteItems> favItemList = [];
  List<ProductModel> productList = [
    ProductModel(
        productName: 'Bread',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productIsFav: false,
        productMrp: 27,
        productQuantity: '1'),
    ProductModel(
        productName: 'Jam',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productIsFav: false,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Toast',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productIsFav: false,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Pav',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productIsFav: false,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Butter',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productIsFav: false,
        productMrp: 30,
        productQuantity: '1'),
  ];
  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  Future<void> getCartAndFavItems() async {
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

  var check = false;

  var favCheck = false;

  @override
  void initState() {
    super.initState();
    getCartAndFavItems().then((_) {
      setState(() {
        cartItemList = cartItemList;
        favItemList = favItemList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryType),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     onPressed: () {
        //       Navigator.of(context).pushNamed(CartPage.routeName);
        //     },
        //   ),
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (widget.categoryName != "")
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.categoryName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(8.0),
                ),
          Expanded(
            child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (ctx, index) {
                  getpCountOrderedFromDatabase(index, check);
                  getFavouriteItemsFromDatabase(index, favCheck);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return ProductDetailScreen(
                                      productModel: productList[index],
                                      productList: productList,
                                    );
                                  }));
                                },
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.network(
                                        productList[index].productImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(productList[index].productName),
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
                                            (productList[index].productMrp !=
                                                    productList[index]
                                                        .productSp)
                                                ? Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${productList[index].productMrp}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[700],
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
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ],
                                                  )
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                  ),
                                          ],
                                        ),
                                        // Text(
                                        //     'Quantity : ${productList[index].productQuantity}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    favCheck = true;
                                    if (productList[index].productIsFav) {
                                      _deleteFav(productList[index]
                                              .productName +
                                          widget.categoryType +
                                          productList[index].productQuantity);
                                    } else {
                                      _insertFav(FavouriteItems(
                                        categoryType: widget.categoryType,
                                        productName:
                                            productList[index].productName,
                                        productQuantity:
                                            productList[index].productQuantity,
                                        productAvailability: productList[index]
                                            .productAvailability,
                                        productImage:
                                            productList[index].productImage,
                                        productMrp:
                                            productList[index].productMrp,
                                        productSp: productList[index].productSp,
                                      ));
                                    }
                                    productList[index].productIsFav =
                                        !productList[index].productIsFav;
                                  });
                                },
                                child: Icon(
                                  (productList[index].productIsFav)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 1.0,
                                  ),
                                ),
                                width: 80,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        if (productList[index]
                                                .productCountOrdered >
                                            0) {
                                          CartItems x = new CartItems(
                                            pImage:
                                                productList[index].productImage,
                                            pName: productList[index].productName,
                                            pCountOrdered: productList[index]
                                                    .productCountOrdered -
                                                1,
                                            pCategoryName:
                                                (widget.categoryName != "")
                                                    ? widget.categoryName
                                                    : widget.categoryType,
                                            pMrp: productList[index].productMrp,
                                            pSp: productList[index].productSp,
                                            pQuantity: productList[index]
                                                .productQuantity,
                                            pAvailability: productList[index]
                                                .productAvailability,
                                          );
                                          if (productList[index]
                                                  .productCountOrdered ==
                                              1) {
                                            _deleteCart(productList[index]
                                                        .productName +
                                                    productList[index]
                                                        .productQuantity)
                                                .then((_) {
                                              setState(() {
                                                check = true;
                                                productList[index]
                                                    .productCountOrdered--;
                                              });
                                            });
                                          } else {
                                            _updateCart(x).then((_) {
                                              setState(() {
                                                check = true;
                                                productList[index]
                                                    .productCountOrdered--;
                                              });
                                            });
                                          }
                                        }
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    VerticalDivider(
                                      width: 10,
                                      thickness: 1,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    Text(
                                      '${productList[index].productCountOrdered}',
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    VerticalDivider(
                                      width: 10,
                                      thickness: 1,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (productList[index]
                                                .productCountOrdered <
                                            5) {
                                          CartItems x = new CartItems(
                                            pImage:
                                                productList[index].productImage,
                                            pName: productList[index].productName,
                                            pCountOrdered: productList[index]
                                                    .productCountOrdered +
                                                1,
                                            pCategoryName:
                                                (widget.categoryName != "")
                                                    ? widget.categoryName
                                                    : widget.categoryType,
                                            pMrp: productList[index].productMrp,
                                            pSp: productList[index].productSp,
                                            pQuantity: productList[index]
                                                .productQuantity,
                                            pAvailability: productList[index]
                                                .productAvailability,
                                          );
                                          if (productList[index]
                                                  .productCountOrdered ==
                                              0) {
                                            _insertCart(x).then((_) {
                                              setState(() {
                                                check = true;
                                                productList[index]
                                                        .productCountOrdered =
                                                    productList[index]
                                                            .productCountOrdered +
                                                        1;
                                              });
                                            });
                                          } else {
                                            _updateCart(x).then((_) {
                                              setState(() {
                                                check = true;
                                                productList[index]
                                                        .productCountOrdered =
                                                    productList[index]
                                                            .productCountOrdered +
                                                        1;
                                              });
                                            });
                                          }
                                        }
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

  void getpCountOrderedFromDatabase(int index, bool check) {
    if (!check) {
      for (int j = 0; j < cartItemList.length; j++) {
        if (cartItemList[j].pName == productList[index].productName &&
            cartItemList[j].pQuantity == productList[index].productQuantity &&
            cartItemList[j].pMrp == productList[index].productMrp) {
          productList[index].productCountOrdered =
              cartItemList[j].pCountOrdered;
        }
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
}
