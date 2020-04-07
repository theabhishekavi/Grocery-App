import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/payment/payment_success.dart';
import 'package:shop/payment/payment_upi.dart';

import 'package:mobile_number/mobile_number.dart';

class PaymentModeScreen extends StatefulWidget {
  final int noOfItems;
  double checkOutPrice;
  final double totalMrp;
  final AddressModel addressModel;
  final List<CartItems> cartItemsList;
  final String userId;
  final bool emptyCart;
  PaymentModeScreen(
      {this.noOfItems,
      this.checkOutPrice,
      this.totalMrp,
      this.addressModel,
      this.emptyCart,
      this.cartItemsList,
      this.userId});

  @override
  _PaymentModeScreenState createState() => _PaymentModeScreenState();
}

class _PaymentModeScreenState extends State<PaymentModeScreen> {
  // String verificationId;
  // TextEditingController _phoneController = TextEditingController(text: "");
  // TextEditingController _otpController = TextEditingController(text: "");
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
                      if (selectedRadioTile == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return PaymentUpi(
                                addressModel: widget.addressModel,
                                cartItemsList: widget.cartItemsList,
                                checkOutPrice: (widget.checkOutPrice < 500)
                                    ? widget.checkOutPrice + 40
                                    : widget.checkOutPrice,
                                noOfItems: widget.noOfItems,
                                totalMrp: widget.totalMrp,
                                userId: widget.userId,
                                emptyCart: widget.emptyCart,
                              );
                            },
                          ),
                        );
                      }
                      if (selectedRadioTile == 2 || selectedRadioTile == 3) {
                        //remember to add 40 to checkoutprice if less than 500
                        initMobileNumberState().then((phoneNumber) {
                          String paymentMode = (selectedRadioTile == 2)
                              ? 'Cash on Delivery'
                              : 'Swipe and Pay';
                          verificationDialog(context, phoneNumber, paymentMode);
                        });
                      }
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

  Future<void> verificationDialog(
      BuildContext context, String phoneNumber, String paymentMode) async {
    // _phoneController = TextEditingController(text: "");
    // _otpController = TextEditingController(text: "");
    // bool smsSent = false;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Verification Required'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Only for Cash on Delivery/Swipe and Pay',
                    style: TextStyle(fontSize: 12),
                  ),
                  (phoneNumber != null)
                      ? (phoneNumber.length > 10)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Phone Number : ${phoneNumber.substring(phoneNumber.length - 10)}'),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Phone Number : $phoneNumber'),
                            )
                      : Text(''),

                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                        builder: (_) {
                          return PaymentSuccess(
                            orderId: widget.userId +
                                DateFormat("dd-MM-yyyy HH:mm:ss")
                                    .format(DateTime.now()),
                            txnId: null,
                            prepaid: false,
                            addressModel: widget.addressModel,
                            cartItemsList: widget.cartItemsList,
                            checkOutPrice: (widget.checkOutPrice < 500)
                                ? widget.checkOutPrice + 40
                                : widget.checkOutPrice,
                            noOfItems: widget.noOfItems,
                            totalMrp: widget.totalMrp,
                            userId: widget.userId,
                            emptyCart: widget.emptyCart,
                            paymentMode: paymentMode,
                          );
                        },
                      ), (Route<dynamic> route) => false);
                    },
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),

                  // (smsSent == false)
                  //       ? Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   vertical: 15.0, horizontal: 5.0),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     shape: BoxShape.rectangle,
                  //                     borderRadius: BorderRadius.only(
                  //                         topLeft: Radius.circular(20.0),
                  //                         topRight: Radius.circular(20.0),
                  //                         bottomLeft: Radius.circular(20.0)),
                  //                     border: Border.all(color: Colors.grey)),
                  //                 child: TextField(
                  //                   controller: _phoneController,
                  //                   decoration: InputDecoration(
                  //                     labelText: 'Phone Number',
                  //                     prefixIcon: Icon(Icons.phone),
                  //                     contentPadding: EdgeInsets.all(0.0),
                  //                     border: InputBorder.none,
                  //                   ),
                  //                   textInputAction: TextInputAction.done,
                  //                   keyboardType: TextInputType.phone,
                  //                   maxLength: 10,
                  //                 ),
                  //               ),
                  //             ),
                  //             RaisedButton(
                  //               onPressed: () {
                  //                 if (_phoneController.text.length != 10) {
                  //                   Fluttertoast.showToast(
                  //                       msg:
                  //                           'Enter a valid 10 digit phone Number');
                  //                 }
                  //                 if (_phoneController.text.length == 10) {
                  //                   initMobileNumberState();
                  //                   // sendOtpToPhoneNUmber(_phoneController.text)
                  //                   //     .then((_) {
                  //                   //   setState(() {
                  //                   //     smsSent = true;
                  //                   //   });
                  //                   // });
                  //                 }
                  //               },
                  //               child: Text(
                  //                 'Send OTP',
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //               color: Theme.of(context).primaryColor,
                  //             )
                  //           ],
                  //         )
                  //       : Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             Center(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(top: 15.0),
                  //                 child: Text(
                  //                   'Phone Number: ${_phoneController.text}',
                  //                   style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontStyle: FontStyle.italic),
                  //                 ),
                  //               ),
                  //             ),
                  //             Center(
                  //               child: Text(
                  //                 'OTP Sent Successfully',
                  //                 style: TextStyle(color: Colors.green),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   vertical: 5.0, horizontal: 5.0),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     shape: BoxShape.rectangle,
                  //                     borderRadius: BorderRadius.only(
                  //                         topLeft: Radius.circular(20.0),
                  //                         topRight: Radius.circular(20.0),
                  //                         bottomLeft: Radius.circular(20.0)),
                  //                     border: Border.all(color: Colors.grey)),
                  //                 child: TextField(
                  //                   controller: _otpController,
                  //                   decoration: InputDecoration(
                  //                     labelText: 'OTP RECEIVED',
                  //                     prefixIcon: Icon(Icons.phone),
                  //                     contentPadding: EdgeInsets.all(0.0),
                  //                     border: InputBorder.none,
                  //                   ),
                  //                   textInputAction: TextInputAction.done,
                  //                   keyboardType: TextInputType.phone,
                  //                   obscureText: true,
                  //                   maxLength: 6,
                  //                 ),
                  //               ),
                  //             ),
                  //             Center(
                  //               child: RaisedButton(
                  //                 onPressed: () {
                  //                   verifyWithOtp(_otpController.text)
                  //                       .then((value) {
                  //                     if (value) {
                  //                       print('success');
                  //                     } else
                  //                       print('failure');
                  //                   });
                  //                 },
                  //                 child: Text(
                  //                   'VERIFY',
                  //                   style: TextStyle(color: Colors.white),
                  //                 ),
                  //                 color: Theme.of(context).primaryColor,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<String> initMobileNumberState() async {
    String mobileNumber = "";
    try {
      mobileNumber = await MobileNumber.mobileNumber;
      return mobileNumber;
    } catch (e) {
      return mobileNumber;
    }
  }

  // Future<void> sendOtpToPhoneNUmber(String phoneNumber) async {
  //   final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
  //     verificationId = verId;
  //   };

  //   final PhoneVerificationCompleted verificationSuccess =
  //       (AuthCredential credential) {
  //     // print('something');
  //     // Map<String,dynamic> map = await json.decode(credential.toString());
  //     // print('otp ${map['jsonObject']['zzb']}');
  //     print(true);

  //     print(credential);
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException exception) {
  //     print(exception.message);
  //   };

  //   final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
  //     verificationId = verId;
  //   };

  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+91$phoneNumber',
  //     verificationCompleted: verificationSuccess,
  //     verificationFailed: verificationFailed,
  //     codeSent: smsCodeSent,
  //     codeAutoRetrievalTimeout: autoRetrievalTimeout,
  //     timeout: const Duration(seconds: 5),
  //   );
  // }

  // Future<bool> verifyWithOtp(String otp) async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.getCredential(
  //       verificationId: verificationId,
  //       smsCode: otp,
  //     );
  //     AuthResult authResult =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     await FirebaseAuth.instance.signOut();

  //     if (authResult != null) {
  //       return true;
  //     } else
  //       return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

}
