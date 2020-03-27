import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/payment/payment_success.dart';
import 'package:shop/utils/strings.dart';
import 'package:upi_india/upi_india.dart';

class PaymentUpi extends StatefulWidget {
  final double checkOutPrice;
  PaymentUpi({this.checkOutPrice});
  @override
  _PaymentUpiState createState() => _PaymentUpiState();
}

class _PaymentUpiState extends State<PaymentUpi> {
  List details = [
    ['Paytm', 'PhonePe', 'GooglePay'],
    ['8051270647@PAYTM', '8051270647@ybl', 'souravshivaay632@okaxis'],
    [UpiIndiaApps.PayTM, UpiIndiaApps.PhonePe, UpiIndiaApps.GooglePay]
  ];
  static const String receiverName = 'ANIL STORE';

  Future transaction;

  Future<String> initiateTransaction(String appType, String receiverUPIID,
      String transactionRefID, double amount) async {
    UpiIndia upi = new UpiIndia(
      app: appType,
      receiverUpiId: receiverUPIID,
      receiverName: receiverName,
      transactionRefId: transactionRefID,
      transactionNote: 'PAYING TO ANIL STORE',
      amount: 1,
    );
    String response = await upi.startTransaction();
    return response;
  }

  SharedPreferences sharedPreferences;
  String userId;

  @override
  initState() {
    super.initState();
    getSharedPreferencesUserId().then((_) {
      setState(() {});
    });
  }

  Future<void> getSharedPreferencesUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(StringKeys.isLoggedIn)) {
      userId = sharedPreferences.getString(StringKeys.userId);
    }
  }

  int selectedRadioTile = 0;
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  String txnId, resCode, txnRef, status, approvalRef, currentTime, orderID;
  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Anil Store'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Select a Payment UPI',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '(PAY ₹ 1)',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: details[0].length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: index + 1,
                  groupValue: selectedRadioTile,
                  title: Text(details[0][index]),
                  onChanged: (val) {
                    setSelectedRadioTile(val);
                  },
                  selected: (selectedRadioTile == index + 1) ? true : false,
                  activeColor: Colors.green,
                );
              },
            ),
            (selectedRadioTile != 0)
                ? RaisedButton(
                    child: Text(
                      'Pay using ${details[0][selectedRadioTile - 1]} UPI',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      transaction = initiateTransaction(
                              details[2][selectedRadioTile - 1],
                              details[1][selectedRadioTile - 1],
                              DateTime.now().millisecondsSinceEpoch.toString(),
                              1)
                          .then((res) {
                        print('Printing Response $res');

                        UpiIndiaResponse _upiResponse = UpiIndiaResponse(res);
                        txnId = _upiResponse.transactionId;
                        resCode = _upiResponse.responseCode;
                        txnRef = _upiResponse.transactionRefId;
                        status = _upiResponse.status;
                        approvalRef = _upiResponse.approvalRefNo;
                        currentTime =
                            DateTime.now().toString();
                        orderID = userId + '($currentTime)';
                        print(orderID);
                        if (status == 'success') {
                          isSuccess = true;
                          // Write  details to firebase

                        } else {
                          Fluttertoast.showToast(msg: 'Payment Failed');
                          isSuccess = false;
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (_) {
                            return PaymentSuccess(
                              orderId: orderID,
                              txnID: txnId,
                              prePaid: true,
                            );
                          }));
                        }
                      });
                    },
                  )
                : Container(),
          ],
        ));
  }
}
