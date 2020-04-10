import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/models/order_type.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderModel orderModel;
  OrderDetailScreen({this.orderModel});
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  String databaseKeyForUser;
  String databaseKeyForAdmin;

  @override
  void initState() {
    super.initState();
    getDatabaseReference().then((_) {
      if (this.mounted) setState(() {});
    });
  }

  Future<void> getDatabaseReference() async {
    await databaseReference
        .child("users")
        .child(widget.orderModel.userId)
        .child("orders")
        .child("active orders")
        .once()
        .then((DataSnapshot snapshot) {
      LinkedHashMap<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        LinkedHashMap<dynamic, dynamic> map2 = value;
        if (map2.containsKey(widget.orderModel.orderId))
          databaseKeyForUser = key;
      });
    });

    await databaseReference
        .child("orders")
        .child("active orders")
        .once()
        .then((DataSnapshot snapshot) {
      LinkedHashMap<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        LinkedHashMap<dynamic, dynamic> map2 = value;
        if (map2.containsKey(widget.orderModel.orderId))
          databaseKeyForAdmin = key;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anil Store'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Delivery Address :-',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.orderModel.addressModel.name}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.orderModel.addressModel.locality}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.orderModel.addressModel.landmark}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.orderModel.addressModel.pincode}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.orderModel.addressModel.phNumber}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
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
                  itemCount: widget.orderModel.cartItems.length,
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
                                          '${index + 1}. ${widget.orderModel.cartItems[index].pName}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Rs ${widget.orderModel.cartItems[index].pSp * widget.orderModel.cartItems[index].pCountOrdered}',
                                                style: TextStyle(),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              (widget
                                                          .orderModel
                                                          .cartItems[index]
                                                          .pMrp !=
                                                      widget.orderModel
                                                          .cartItems[index].pSp)
                                                  ? Row(
                                                      children: <Widget>[
                                                        Text(
                                                          '${widget.orderModel.cartItems[index].pMrp * widget.orderModel.cartItems[index].pCountOrdered}',
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
                                                          '${discountPer(widget.orderModel.cartItems[index].pMrp * widget.orderModel.cartItems[index].pCountOrdered, widget.orderModel.cartItems[index].pSp * widget.orderModel.cartItems[index].pCountOrdered)}% off',
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
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                              'No. of Items bought : ${widget.orderModel.cartItems[index].pCountOrdered}'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Image.network(widget
                                        .orderModel.cartItems[index].pImage),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Total number of Products: ${widget.orderModel.noOfItems}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Order Placed On: ${widget.orderModel.orderPlacedDate}',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Estimated Delivery Date: ${widget.orderModel.estimatedDeliveryTime}',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Total Amount: Rs.${widget.orderModel.amount}',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Payment Mode: ${widget.orderModel.paymentMode}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              (widget.orderModel.orderIsActive &&
                      widget.orderModel.delivered == false)
                  ? Center(
                      child: RaisedButton(
                        onPressed: () {
                          cancelOrder(context);
                        },
                        child: Text(
                          "CANCEL ORDER",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : Container(),
              (widget.orderModel.delivered == false &&
                      widget.orderModel.orderIsActive == false)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Order Cancelled',
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cancelOrder(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(
              'Are you sure, you want to cancel this order?',
              style: TextStyle(fontSize: 17),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "NO",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (databaseKeyForUser != null &&
                        databaseKeyForAdmin != null) {
                      bool deliveredStatus = true;
                      Fluttertoast.showToast(
                        msg: "Order Cancellation In Progress",
                      );
                      await databaseReference
                          .child("users")
                          .child(widget.orderModel.userId)
                          .child("orders")
                          .child("active orders")
                          .child(databaseKeyForUser)
                          .child(widget.orderModel.orderId)
                          .child("delivered")
                          .once()
                          .then((DataSnapshot snapshot) {
                        deliveredStatus = snapshot.value;
                      });

                      if (widget.orderModel.prepaid) {
                        //Prepaid Order need to select a refund UPId
                        Navigator.of(context).pop();
                        refundPrepaidDialog(context);
                      } else {
                        if (deliveredStatus == false) {
                          await databaseReference
                              .child("users")
                              .child(widget.orderModel.userId)
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForUser)
                              .child(widget.orderModel.orderId)
                              .child("orderIsActive")
                              .set(false);

                          await databaseReference
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForAdmin)
                              .child(widget.orderModel.orderId)
                              .child("orderIsActive")
                              .set(false);

                          var oldValue;
                          await databaseReference
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForAdmin)
                              .once()
                              .then((DataSnapshot snapshot) {
                            oldValue = snapshot.value;
                          });
                          await databaseReference
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForAdmin)
                              .remove();

                          await databaseReference
                              .child('orders')
                              .child('cancel orders')
                              .push()
                              .set(oldValue);

                          Fluttertoast.showToast(msg: "Order Cancelled");
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(builder: (_) {
                            widget.orderModel.orderIsActive = false;
                            return OrderDetailScreen(
                              orderModel: widget.orderModel,
                            );
                          }));
                        } else
                          Fluttertoast.showToast(
                              msg: "Order already delivered");
                      }
                    }
                  },
                  child: Text(
                    "YES",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          );
        });
  }

  Future<void> refundPrepaidDialog(BuildContext context) async {
    TextEditingController upiController = TextEditingController(text: "");
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Center(
              child: Text('Refund Amount : Rs.${widget.orderModel.amount}'),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Accepted UPI: (Paytm/PhonePe/GooglePay)'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: upiController,
                          decoration: InputDecoration(
                              hintText: "*****@paytm",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  Text(
                      "Note: Your Amount will be credited in 3-4 business days"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      onPressed: () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        if (upiController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg:
                                  "First enter your Paytm/Phone/GooglePay Upi");
                        } else if (!upiController.text.contains('@') ||
                            upiController.text.length <= 4) {
                          Fluttertoast.showToast(msg: 'Enter a valid Upi');
                        } else {
                          Fluttertoast.showToast(msg: 'Please Wait');
                          bool deliveredStatus = true;
                          await databaseReference
                              .child("users")
                              .child(widget.orderModel.userId)
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForUser)
                              .child(widget.orderModel.orderId)
                              .child("delivered")
                              .once()
                              .then((DataSnapshot snapshot) {
                            deliveredStatus = snapshot.value;
                          });
                          if (deliveredStatus == false) {
                            await databaseReference
                                .child("users")
                                .child(widget.orderModel.userId)
                                .child("orders")
                                .child("active orders")
                                .child(databaseKeyForUser)
                                .child(widget.orderModel.orderId)
                                .child("orderIsActive")
                                .set(false);
                            await databaseReference
                                .child("users")
                                .child(widget.orderModel.userId)
                                .child("orders")
                                .child("active orders")
                                .child(databaseKeyForUser)
                                .child(widget.orderModel.orderId)
                                .child("refundUpi")
                                .set(upiController.text);


                                //admin
                            await databaseReference
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForAdmin)
                              .child(widget.orderModel.orderId)
                              .child("orderIsActive")
                              .set(false);

                            await databaseReference
                                .child("orders")
                                .child("active orders")
                                .child(databaseKeyForAdmin)
                                .child(widget.orderModel.orderId)
                                .child("refundUpi")
                                .set(upiController.text);
                            
                            var oldValue;
                          await databaseReference
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForAdmin)
                              .once()
                              .then((DataSnapshot snapshot) {
                            oldValue = snapshot.value;
                          });
                          await databaseReference
                              .child("orders")
                              .child("active orders")
                              .child(databaseKeyForAdmin)
                              .remove();

                          await databaseReference
                              .child('orders')
                              .child('cancel orders')
                              .push()
                              .set(oldValue);

                            
                            Fluttertoast.showToast(msg: "Order Cancelled");
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(builder: (_) {
                              widget.orderModel.orderIsActive = false;
                              return OrderDetailScreen(
                                orderModel: widget.orderModel,
                              );
                            }));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Order already delivered");
                          }
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
