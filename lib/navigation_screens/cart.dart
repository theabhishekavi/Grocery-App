import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/Screens/order_checkout_screen.dart';
import 'package:shop/drawer/my_address_screen.dart';
import 'package:shop/login/login_screen.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/utils/strings.dart';
import '../database/cartTable_helper.dart';

class CartPage extends StatefulWidget {
  static const routeName = "/cartPageRoute";
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartTableHelper databaseHelper = CartTableHelper();
  double _checkoutPrice = 0.0;
  List<CartItems> cartItemList = [];
  SharedPreferences sharedPreferences;

  static double calPrice(List<CartItems> cartItemList) {
    double _sum = 0.0;
    for (int i = 0; i < cartItemList.length; i++) {
      _sum += cartItemList[i].pSp * cartItemList[i].pCountOrdered;
    }
    return _sum;
  }

  Future<void> getCartItems() async {
    sharedPreferences = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> list = await databaseHelper.getCartMapList();
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
      cartItemList.add(x);
    }
  }

  @override
  initState() {
    super.initState();
    getCartItems().then((_) {
      setState(() {
        cartItemList = cartItemList;
        _checkoutPrice = calPrice(cartItemList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.grey[700]),
        ),
        backgroundColor: Colors.grey[300],
        actions: <Widget>[
          FlatButton(
            color: Colors.grey[400],
            onPressed: () {
              bool isLoggedIN;
              isLoggedIN = sharedPreferences.getBool(StringKeys.isLoggedIn);

              if (_checkoutPrice == 0.0) {
                Fluttertoast.showToast(msg: "Add items in Cart");
              } else if (isLoggedIN == null) {
                Fluttertoast.showToast(msg: "Log in to your Account");
                Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
              } else {
                String userId = sharedPreferences.getString(StringKeys.userId);
                List<String> defaultAddress = sharedPreferences
                    .getStringList(userId + StringKeys.defaultAddressKey);
                if (defaultAddress == null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_){
                    return MyAddressScreen();
                  }));

                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return OrderCheckout(
                          cartItemList: cartItemList,
                          checkOutPrice: _checkoutPrice,
                          emptyCart: true,
                        );
                      },
                    ),
                  );
                }
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('CHECKOUT'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Rs $_checkoutPrice',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: cartItemList.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      child: Image.network(cartItemList[index].pImage),
                    ),
                    title: Text(cartItemList[index].pName),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: SizedBox(
                                child: Text(cartItemList[index].pCategoryName),
                                width: 120,
                              ),
                            ),
                            Text('Quantity: ${cartItemList[index].pQuantity}'),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            _delete(cartItemList[index].pName +
                                cartItemList[index].pQuantity);
                            Fluttertoast.showToast(
                                msg: "Item removed from the cart");
                            setState(() {
                              cartItemList.removeAt(index);
                              _checkoutPrice = calPrice(cartItemList);
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Rs ${cartItemList[index].pMrp * cartItemList[index].pCountOrdered}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          'Rs ${cartItemList[index].pSp * cartItemList[index].pCountOrdered}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 1.0),
                          ),
                          width: 75,
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  if (cartItemList[index].pCountOrdered == 1) {
                                    _delete(cartItemList[index].pName +
                                        cartItemList[index].pQuantity);
                                    setState(() {
                                      cartItemList.removeAt(index);
                                      _checkoutPrice = calPrice(cartItemList);
                                    });
                                  } else if (cartItemList[index].pCountOrdered >
                                      1) {
                                    CartItems x = new CartItems(
                                      pImage: cartItemList[index].pImage,
                                      pName: cartItemList[index].pName,
                                      pCountOrdered:
                                          cartItemList[index].pCountOrdered - 1,
                                      pCategoryName:
                                          cartItemList[index].pCategoryName,
                                      pMrp: cartItemList[index].pMrp,
                                      pSp: cartItemList[index].pSp,
                                      pQuantity: cartItemList[index].pQuantity,
                                      pAvailability:
                                          cartItemList[index].pAvailability,
                                    );
                                    _update(x);
                                    setState(() {
                                      cartItemList[index].pCountOrdered--;
                                      _checkoutPrice = calPrice(cartItemList);
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
                                '${cartItemList[index].pCountOrdered}',
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
                                  if (cartItemList[index].pCountOrdered < 5) {
                                    CartItems x = new CartItems(
                                      pImage: cartItemList[index].pImage,
                                      pName: cartItemList[index].pName,
                                      pCountOrdered:
                                          cartItemList[index].pCountOrdered + 1,
                                      pCategoryName:
                                          cartItemList[index].pCategoryName,
                                      pMrp: cartItemList[index].pMrp,
                                      pSp: cartItemList[index].pSp,
                                      pQuantity: cartItemList[index].pQuantity,
                                      pAvailability:
                                          cartItemList[index].pAvailability,
                                    );
                                    _update(x);
                                    setState(() {
                                      cartItemList[index].pCountOrdered++;
                                      _checkoutPrice = calPrice(cartItemList);
                                    });
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
          },
        ),
      ),
    );
  }

  Future<void> _update(CartItems cartItems) async {
    int result = await databaseHelper.updateCart(cartItems);

    print('$result update');
  }

  Future<void> _delete(String id) async {
    int result = await databaseHelper.deleteCartItem(id);

    print('$result delete');
  }
}
