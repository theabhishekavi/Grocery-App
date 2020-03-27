import 'package:flutter/material.dart';
import 'package:shop/payment/payment_upi.dart';

class PaymentModeScreen extends StatefulWidget {
  int noOfItems;
  double checkOutPrice;
  double totalMrp;
  PaymentModeScreen({this.noOfItems, this.checkOutPrice, this.totalMrp});

  @override
  _PaymentModeScreenState createState() => _PaymentModeScreenState();
}

class _PaymentModeScreenState extends State<PaymentModeScreen> {
  int selectedRadioTile;

  @override
  void initState() {
    selectedRadioTile = 0;
    super.initState();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select a Payment Mode',
                style: TextStyle(fontSize: 20),
              ),
            ),
            RadioListTile(
              value: 1,
              groupValue: selectedRadioTile,
              title: Text('Pay Online'),
              onChanged: (val) {
                setSelectedRadioTile(val);
              },
              selected: (selectedRadioTile == 1) ? true : false,
              activeColor: Colors.green,
            ),
            RadioListTile(
              value: 2,
              groupValue: selectedRadioTile,
              title: Text('Cash on Delivery'),
              onChanged: (val) {
                setSelectedRadioTile(val);
              },
              activeColor: Colors.green,
              selected: (selectedRadioTile == 2) ? true : false,
            ),
            RadioListTile(
              value: 3,
              groupValue: selectedRadioTile,
              title: Text('Swipe and Pay'),
              subtitle: Text('(During the time of Delivery)'),
              onChanged: (val) {
                setSelectedRadioTile(val);
              },
              activeColor: Colors.green,
              selected: (selectedRadioTile == 3) ? true : false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3.0,
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[50],
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
                                  '${widget.noOfItems}',
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
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 4.0),
                                child: Column(
                                  children: <Widget>[
                                    Text('Rs. ${widget.checkOutPrice.round()} ',
                                        style: TextStyle(fontSize: 15)),
                                    Text('(Rs.${widget.totalMrp.round()})',
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
                              'You will save Rs.${(widget.totalMrp - widget.checkOutPrice).round()} on this order',
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.green, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            (selectedRadioTile != 0)
                ? RaisedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return PaymentUpi();
                      }));
                    },
                    child: Text(
                      'Proceed to Payment',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  )
                : Padding(
                    padding: const EdgeInsets.all(0.0),
                  ),
          ],
        ),
      ),
    );
  }
}
