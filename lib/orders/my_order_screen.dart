import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/models/order_type.dart';
import 'package:shop/orders/order_detail_screen.dart';
import 'package:shop/utils/strings.dart';

class MyOrderScreen extends StatefulWidget {
  static const routeName = '/MyOrderScreenRouteName';

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool loadingState = true;
  SharedPreferences sharedPreferences;
  String userId;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  List<OrderModel> activeOrderModelList = [];

  @override
  void initState() {
    super.initState();

    getFirebaseOrder().then((_) {
      setState(() {
        activeOrderModelList.sort((one, two) {
          return two.orderId.compareTo(one.orderId);
        });
        loadingState = false;
      });
    });
  }

  Future<void> getFirebaseOrder() async {
    String orderId;
    bool prepaid;
    AddressModel addressModel;
    List<CartItems> cartItemsList = [];
    String phoneNumber; //only for COD/SOD
    int amount;
    String txnId;
    int noOfItems;
    bool delivered;
    String orderPlacedDate;
    String estimatedDeliveryTime;
    String paymentMode;
    bool orderIsActive;
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString(StringKeys.userId);
    await databaseReference
        .child('users')
        .child(userId)
        .child('orders')
        .child('active orders')
        .once()
        .then((DataSnapshot snapshot) {
      LinkedHashMap<dynamic, dynamic> map = snapshot.value;
      if (map != null)
        map.forEach((key, value) {
          LinkedHashMap<dynamic, dynamic> map2 = value;
          if (map2 != null)
            map2.forEach((orderIDFromMap, orderValues) {
              orderId = orderIDFromMap;
              amount = orderValues['amount'];
              orderPlacedDate = orderValues['orderPlacedDate'];
              addressModel = AddressModel(
                name: orderValues['address']['addName'],
                locality: orderValues['address']['addLocality'],
                landmark: orderValues['address']['addLandmark'],
                phNumber: orderValues['address']['addPhoneNumber'],
                pincode: orderValues['address']['addPincode'],
              );
              phoneNumber = orderValues['phoneNumber'];
              paymentMode = orderValues['paymentMode'];
              estimatedDeliveryTime = orderValues['estimatedDeliveryTime'];
              noOfItems = orderValues['noOfItems'];
              prepaid = orderValues['prepaid'];
              delivered = orderValues['delivered'];
              txnId = orderValues['txnId'];
              orderIsActive = orderValues['orderIsActive'];

              List<dynamic> cartListFromMap = orderValues['cartItems'];

              cartItemsList = [];
              for (int i = 1; i < cartListFromMap.length; i++) {
                CartItems cartItems = new CartItems(
                  pName: cartListFromMap[i]['pName'],
                  pImage: cartListFromMap[i]['pImage'],
                  pAvailability: cartListFromMap[i]['pAvailability'],
                  pCategoryName: cartListFromMap[i]['pCategoryName'],
                  pCountOrdered: cartListFromMap[i]['pCountOrdered'],
                  pMrp: cartListFromMap[i]['pMrp'],
                  pSp: cartListFromMap[i]['pSp'],
                  pQuantity: cartListFromMap[i]['pQuantity'],
                );
                cartItemsList.add(cartItems);
              }

              OrderModel orderModel = OrderModel(
                addressModel: addressModel,
                amount: amount,
                cartItems: cartItemsList,
                estimatedDeliveryTime: estimatedDeliveryTime,
                noOfItems: noOfItems,
                orderId: orderId,
                orderPlacedDate: orderPlacedDate,
                paymentMode: paymentMode,
                phoneNumber: phoneNumber,
                prepaid: prepaid,
                txnId: txnId,
                userId: userId,
                delivered: delivered,
                orderIsActive: orderIsActive,
              );
              activeOrderModelList.add(orderModel);
            });
        });
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
        actions: <Widget>[],
        title: Text('My Orders'),
      ),
      body: SingleChildScrollView(
        child: (loadingState)
            ? Center(child: loadingIndicator)
            : (activeOrderModelList.length == 0)
                ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top:250),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.sentiment_dissatisfied,size: 60,color: Theme.of(context).primaryColor,),
                        SizedBox(height: 5,),
                        Text(
                          "No orders yet!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22,color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: activeOrderModelList.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  (activeOrderModelList[index].delivered)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            'Order Delivered Successfully',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontStyle: FontStyle.italic,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        )
                                      : (!activeOrderModelList[index]
                                              .orderIsActive)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                'Order Cancelled',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.italic,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                            )
                                          : Container(),
                                  Text(
                                    'Order ID : ${activeOrderModelList[index].orderId}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${activeOrderModelList[index].cartItems[0].pName}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Total Amount : Rs.${activeOrderModelList[index].amount}'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Payment Mode : ${activeOrderModelList[index].paymentMode}'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Order Placed On : ${activeOrderModelList[index].orderPlacedDate}'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  return OrderDetailScreen(
                                                    orderModel:
                                                        activeOrderModelList[
                                                            index],
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'View Order Details',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
      ),
    );
  }
}
