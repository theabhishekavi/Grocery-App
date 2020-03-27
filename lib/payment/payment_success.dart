import 'package:flutter/material.dart';

class PaymentSuccess extends StatelessWidget {
  final String orderId, txnID;
  final bool prePaid;
  PaymentSuccess({this.orderId, this.txnID, this.prePaid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Placed'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:80,bottom: 8.0),
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
                        'Order ID : $orderId',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
