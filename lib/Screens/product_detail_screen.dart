import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Screens/order_checkout_screen.dart';
import 'package:shop/Screens/product_screen.dart';
import 'package:shop/database/cartTable_helper.dart';
import 'package:shop/database/favourite_helper.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/models/favourite_items.dart';
import 'package:shop/models/product_quantity_variant.dart';
import 'package:shop/models/product_type.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/ProductDetailScreenRouteName';
  ProductTight productTight;
  List<dynamic> productTightList;
  ProductDetailScreen({this.productTight, this.productTightList});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<dynamic> productTightListWithoutProductTight = [];
  FavouriteHelper favouriteHelper = FavouriteHelper();
  CartTableHelper cartDatabaseHelper = CartTableHelper();
  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  @override
  void initState() {
    for (int i = 0; i < widget.productTightList.length; i++) {
      if (widget.productTightList[i] != widget.productTight) {
        productTightListWithoutProductTight.add(widget.productTightList[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return ProductScreen(
            categoryName: widget.productTight.categoryName,
            categoryType: widget.productTight.categoryType,
          );
        }));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Anil Store'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 200,
                      child: FittedBox(
                        child: Image.network(
                          widget.productTight.productImage,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (widget.productTight.productIsFav) {
                            _deleteFav(widget.productTight.productName +
                                widget.productTight.categoryType +
                                widget.productTight.productQuantity);
                          } else {
                            _insertFav(
                              FavouriteItems(
                                categoryType: widget.productTight.categoryType,
                                productName: widget.productTight.productName,
                                productQuantity:
                                    widget.productTight.productQuantity,
                                productAvailability:
                                    widget.productTight.productAvailability,
                                productImage: widget.productTight.productImage,
                                productMrp: widget.productTight.productMrp,
                                productSp: widget.productTight.productSp,
                              ),
                            );
                          }
                          widget.productTight.productIsFav =
                              !widget.productTight.productIsFav;
                        });
                      },
                      child: (widget.productTight.productIsFav)
                          ? Icon(
                              Icons.favorite,
                              color: Theme.of(context).accentColor,
                              size: 30,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).accentColor,
                              size: 30,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.productTight.productName,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Row(
                  children: <Widget>[
                    Card(
                      elevation: 3,
                      child: Text(
                        'Rs. ${widget.productTight.productSp}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    (widget.productTight.productMrp !=
                            widget.productTight.productSp)
                        ? Row(
                            children: <Widget>[
                              Text(
                                'Rs. ${widget.productTight.productMrp}',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${discountPer(widget.productTight.productMrp, widget.productTight.productSp)}% off',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              ),
                            ],
                          )
                        : Padding(padding: EdgeInsets.all(0.0))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Offer - Buy 5 get 20% off',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Highlights  ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  // color: Theme.of(context).primaryColor,
                  child: Text(
                    'Share this Item! ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Ratings',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Questions & Answers',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        'Ask a Question',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Similiar Products',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: min(6, productTightListWithoutProductTight.length),
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (_) {
                        return ProductDetailScreen(
                          productTight:
                              productTightListWithoutProductTight[index],
                          productTightList: widget.productTightList,
                        );
                      }));
                    },
                    child: Card(
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.width / 5,
                            child: Image.network(
                              productTightListWithoutProductTight[index]
                                  .productImage,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            productTightListWithoutProductTight[index]
                                .productName,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return ProductScreen(
                                categoryName: widget.productTight.categoryName,
                                categoryType: widget.productTight.categoryType,
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                        'VIEW MORE',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[100],
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        buyNowDialogBox(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_basket,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        addToCartDialogBox(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          (widget.productTight.productCountOrdered > 0)
                              ? (widget.productTight.productCountOrdered == 1)
                                  ? Text(
                                      '${widget.productTight.productCountOrdered} item in cart',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : Text(
                                      '${widget.productTight.productCountOrdered} item(s) in cart',
                                      style: TextStyle(fontSize: 18),
                                    )
                              : Text(
                                  "Add to Cart",
                                  style: TextStyle(color: Colors.blue),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0.0,
        ),
      ),
    );
  }

  Future<void> _insertFav(FavouriteItems favouriteItems) async {
    await favouriteHelper.insertFavouriteItem(favouriteItems);
  }

  Future<void> _deleteFav(String id) async {
    await favouriteHelper.deleteFavouriteItem(id);
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

  Future<void> buyNowDialogBox(BuildContext context) async {
    int productCountOrdered = 0;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  width: 80,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'Select Quantity',
                          style: TextStyle(fontSize: 20),
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
                        width: 100,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (productCountOrdered > 0) {
                                  setState(() {
                                    productCountOrdered--;
                                  });
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
                              '$productCountOrdered',
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
                                if (productCountOrdered <
                                    widget.productTight.productCount) {
                                  setState(() {
                                    productCountOrdered++;
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'You can add only ${widget.productTight.productCount} item(s)');
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('CANCEL'),
                            color: Theme.of(context).primaryColor,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (productCountOrdered > 0) {
                                Navigator.of(context).pop();
                                List<CartItems> cartItemsList = [];
                                cartItemsList.add(new CartItems(
                                  pImage: widget.productTight.productImage,
                                  pName: widget.productTight.productName,
                                  pCountOrdered:
                                     productCountOrdered,
                                  pCategoryName:
                                      widget.productTight.categoryName,
                                  pMrp: widget.productTight.productMrp,
                                  pSp: widget.productTight.productSp,
                                  pQuantity:
                                      widget.productTight.productQuantity,
                                  pAvailability:
                                      widget.productTight.productAvailability,
                                ));
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return OrderCheckout(
                                        cartItemList: cartItemsList,
                                        checkOutPrice: (widget.productTight.productSp *productCountOrdered)*1.0,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Add an item to buy');
                              }
                            },
                            child: Text('BUY'),
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> addToCartDialogBox(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  width: 80,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'Select Quantity',
                          style: TextStyle(fontSize: 20),
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
                        width: 100,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (widget.productTight.productCountOrdered >
                                    0) {
                                  CartItems x = new CartItems(
                                    pImage: widget.productTight.productImage,
                                    pName: widget.productTight.productName,
                                    pCountOrdered: widget
                                            .productTight.productCountOrdered -
                                        1,
                                    pCategoryName:
                                        widget.productTight.categoryName,
                                    pMrp: widget.productTight.productMrp,
                                    pSp: widget.productTight.productSp,
                                    pQuantity:
                                        widget.productTight.productQuantity,
                                    pAvailability:
                                        widget.productTight.productAvailability,
                                  );
                                  if (widget.productTight.productCountOrdered ==
                                      1) {
                                    _deleteCart(widget
                                                .productTight.productName +
                                            widget.productTight.productQuantity)
                                        .then((_) {
                                      setState(() {
                                        widget
                                            .productTight.productCountOrdered--;
                                      });
                                    });
                                  } else {
                                    _updateCart(x).then((_) {
                                      setState(() {
                                        widget
                                            .productTight.productCountOrdered--;
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
                              '${widget.productTight.productCountOrdered}',
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
                                if (widget.productTight.productCountOrdered <
                                    5) {
                                  CartItems x = new CartItems(
                                    pImage: widget.productTight.productImage,
                                    pName: widget.productTight.productName,
                                    pCountOrdered: widget
                                            .productTight.productCountOrdered +
                                        1,
                                    pCategoryName:
                                        widget.productTight.categoryName,
                                    pMrp: widget.productTight.productMrp,
                                    pSp: widget.productTight.productSp,
                                    pQuantity:
                                        widget.productTight.productQuantity,
                                    pAvailability:
                                        widget.productTight.productAvailability,
                                  );
                                  if (widget.productTight.productCountOrdered ==
                                      0) {
                                    _insertCart(x).then((_) {
                                      setState(() {
                                        widget.productTight
                                            .productCountOrdered = widget
                                                .productTight
                                                .productCountOrdered +
                                            1;
                                      });
                                    });
                                  } else {
                                    _updateCart(x).then((_) {
                                      setState(() {
                                        widget.productTight
                                            .productCountOrdered = widget
                                                .productTight
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
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (widget.productTight.productCountOrdered > 0) {
                            if (widget.productTight.productCountOrdered == 1)
                              Fluttertoast.showToast(
                                  msg:
                                      '${widget.productTight.productCountOrdered} item added successfully to the cart');
                            else
                              Fluttertoast.showToast(
                                  msg:
                                      '${widget.productTight.productCountOrdered} item(s) added successfully to the cart');
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) {
                                  return ProductDetailScreen(
                                    productTight: widget.productTight,
                                    productTightList: widget.productTightList,
                                  );
                                },
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    '${widget.productTight.productName} is not added to cart');
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) {
                                  return ProductDetailScreen(
                                    productTight: widget.productTight,
                                    productTightList: widget.productTightList,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        child: Text('CONFIRM'),
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
