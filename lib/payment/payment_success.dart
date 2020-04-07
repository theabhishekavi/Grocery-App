import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/database/cartTable_helper.dart';
import 'package:shop/home_page.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/models/order_type.dart';

class PaymentSuccess extends StatefulWidget {
  final int noOfItems;
  final String orderId, txnId, userId;
  final bool prepaid;
  final double checkOutPrice;
  final double totalMrp;
  final AddressModel addressModel;
  final List<CartItems> cartItemsList;
  String phoneNumber;
  final bool emptyCart;
  final String paymentMode;

  PaymentSuccess(
      {this.orderId,
      this.noOfItems,
      this.txnId,
      this.prepaid,
      this.userId,
      this.addressModel,
      this.cartItemsList,
      this.checkOutPrice,
      this.phoneNumber,
      this.emptyCart,
      this.paymentMode,
      this.totalMrp});

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  CartTableHelper cartTableHelper = CartTableHelper();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  bool loading = true;
  String deliveryTime = "";

  @override
  void initState() {
    super.initState();
    addDataToFirebase().then((_) {
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> addDataToFirebase() async {
    if (widget.phoneNumber == null) {
      widget.phoneNumber = "";
    }
    OrderModel orderModel = new OrderModel(
      addressModel: widget.addressModel,
      amount: (widget.checkOutPrice).round(),
      cartItems: widget.cartItemsList,
      noOfItems: widget.noOfItems,
      orderId: widget.orderId,
      orderPlacedDate: widget.orderId.substring(widget.userId.length),
      phoneNumber: widget.phoneNumber,
      prepaid: widget.prepaid,
      txnId: widget.txnId,
      userId: widget.userId,
      estimatedDeliveryTime: calculateDeliveryTime(),
      paymentMode: widget.paymentMode,
      delivered: false,
      orderIsActive: true,
    );
    await databaseReference
        .child('orders')
        .child('active orders')
        .push()
        .set(orderModel.toOrderMap());
    await databaseReference
        .child('users')
        .child(widget.userId)
        .child('orders')
        .child('active orders')
        .push()
        .set(orderModel.toOrderMap());

    if (widget.emptyCart) cartTableHelper.emptyCart();
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Summary'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: (loading)
              ? Center(child: loadingIndicator)
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 8.0),
                      child: CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.done,
                          size: 50,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                      ),
                    ),
                    Text(
                      'Congratulations!',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Your order is placed successfully',
                      style: TextStyle(fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Order ID : ${widget.orderId}',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'PAYMENT RECEIVED : Rs.${widget.checkOutPrice}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: SizedBox(
                                    width: double.infinity,
                                    child: (widget.prepaid)
                                        ? Text(
                                            'PAYMENT METHOD : ONLINE(${widget.paymentMode})',
                                            style: TextStyle(fontSize: 15),
                                          )
                                        : Text(
                                            'PAYMENT METHOD : ${widget.paymentMode}',
                                            style: TextStyle(fontSize: 15),
                                          )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'ESTIMATED DELIVERY TIME: ${calculateDeliveryTime()}',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '(We will keep you posted about the status of your order via SMS)',
                                  style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Note: Order of Sunday will be delivered on Monday',
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).accentColor),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          child: Text(
                            'Continue Shopping',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomePage.routeName,
                                (Route<dynamic> route) => false);
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  String calculateDeliveryTime() {
    deliveryTime = widget.orderId.substring((widget.userId.length));
    List<String> list = (deliveryTime.split(' '));
    String date = list[0];
    String time = list[1];
    if (int.parse(time.substring(0, 2)) >= 13 || DateTime.now().weekday == DateTime.sunday) {
      date = DateFormat("dd-MM-yyyy")
          .format(DateTime.now().add(new Duration(days: 1)));
      deliveryTime = date + " (1 PM)";
    } else {
      deliveryTime = date + " (8 PM)";
    }
    return deliveryTime;
  }
}
