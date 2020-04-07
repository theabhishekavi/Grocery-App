import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/address/change_address.dart';
import 'package:shop/payment/payment_mode.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/utils/strings.dart';

class OrderCheckout extends StatefulWidget {
  static const routeName = '/OrderCheckoutRouteName';
  final List<CartItems> cartItemList;
  final double checkOutPrice;
  bool emptyCart;

  OrderCheckout({this.cartItemList, this.checkOutPrice, this.emptyCart});
  @override
  _OrderCheckoutState createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends State<OrderCheckout> {
  var _totalMrp = 0.0;
  SharedPreferences sharedPreferences;
  AddressModel addressModel = new AddressModel();
  List<String> defaultAddress = [];
  String userId;

  Future<void> getDefaultAddress() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString(StringKeys.userId);
    if (sharedPreferences.containsKey(userId + StringKeys.defaultAddressKey)) {
      defaultAddress = sharedPreferences
          .getStringList(userId + StringKeys.defaultAddressKey);
      print(defaultAddress[0]);
      addressModel = new AddressModel(
        name: defaultAddress[0],
        locality: defaultAddress[1],
        landmark: defaultAddress[2],
        pincode: defaultAddress[3],
        phNumber: defaultAddress[4],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _totalMrp = calPrice(widget.cartItemList);
    getDefaultAddress().then((_) {
      setState(() {});
    });
  }

  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  static double calPrice(List<CartItems> cartItemList) {
    double _sum = 0.0;
    for (int i = 0; i < cartItemList.length; i++) {
      _sum += cartItemList[i].pMrp * cartItemList[i].pCountOrdered;
    }
    return _sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Checkout'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      (defaultAddress.length == 5)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${defaultAddress[0]}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${defaultAddress[1]}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  '${defaultAddress[2]}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  '${defaultAddress[3]}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  '${defaultAddress[4]}',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            )
                          : Text('No address Added'),
                      RaisedButton(
                        child: Text(
                          'Change Address',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return ChangeAddress(
                                  cartItemList: widget.cartItemList,
                                  checkOutPrice: widget.checkOutPrice,
                                  emptyCart: widget.emptyCart,
                                );
                              },
                            ),
                          );
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'PRODUCT DETAILS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: widget.cartItemList.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${index + 1}. ${widget.cartItemList[index].pName}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'Rs ${widget.cartItemList[index].pSp * widget.cartItemList[index].pCountOrdered}',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            (widget.cartItemList[index].pMrp !=
                                                    widget.cartItemList[index]
                                                        .pSp)
                                                ? Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${widget.cartItemList[index].pMrp * widget.cartItemList[index].pCountOrdered}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[700],
                                                            fontSize: 17,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '${discountPer(widget.cartItemList[index].pMrp * widget.cartItemList[index].pCountOrdered, widget.cartItemList[index].pSp * widget.cartItemList[index].pCountOrdered)}% off',
                                                        style: TextStyle(
                                                            fontSize: 17,
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
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Image.network(
                                        widget.cartItemList[index].pImage),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'PRICE DETAILS',
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'No. of items',
                              style: TextStyle(fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '${widget.cartItemList.length}',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Price', style: TextStyle(fontSize: 17)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Column(
                                children: <Widget>[
                                  Text('Rs. ${widget.checkOutPrice.round()} ',
                                      style: TextStyle(fontSize: 15)),
                                  Text('(Rs.${_totalMrp.round()})',
                                      style: TextStyle(
                                          fontSize: 13,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Delivery Charges',
                                style: TextStyle(fontSize: 17)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: (widget.checkOutPrice < 500.0)
                                  ? Text(
                                      'Rs. 40',
                                      style: TextStyle(fontSize: 17),
                                    )
                                  : Text('Free',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green,
                                      )),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Amount Payable',
                                style: TextStyle(fontSize: 17)),
                            (widget.checkOutPrice < 500.0)
                                ? Text(
                                    'Rs. ${(widget.checkOutPrice + 40.0).round()}',
                                    style: TextStyle(fontSize: 17),
                                  )
                                : Text(
                                    'Rs. ${(widget.checkOutPrice).round()}',
                                    style: TextStyle(fontSize: 17),
                                  ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'You will save Rs.${(_totalMrp - widget.checkOutPrice).round()} on this order',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.green, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey[100],
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      (widget.checkOutPrice < 500.0)
                          ? Text(
                              'Amount (Rs. ${(widget.checkOutPrice + 40.0).round()})',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).primaryColor),
                            )
                          : Text(
                              'Amount (Rs. ${(widget.checkOutPrice).round()})',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).primaryColor),
                            ),
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 3,
                  color: Colors.grey[200],
                ),
                InkWell(
                  onTap: () {
                    if (defaultAddress.length == 5) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return PaymentModeScreen(
                              checkOutPrice: widget.checkOutPrice,
                              noOfItems: widget.cartItemList.length,
                              totalMrp: _totalMrp,
                              addressModel: addressModel,
                              cartItemsList: widget.cartItemList,
                              userId: userId,
                              emptyCart: widget.emptyCart,
                            );
                          },
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: 'Address Not Found');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Continue",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
