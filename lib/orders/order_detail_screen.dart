import 'package:flutter/material.dart';
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
                        onPressed: () {},
                        child: Text("CANCEL ORDER",style: TextStyle(color: Colors.white),),
                        color: Theme.of(context).accentColor,
                      ),
                  )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
