import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = '/Paymentpage';
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckOut()async{
    var options ={
      'key':'rzp_test_4dd6HMRtEO99BB',
      'amount': 250*100,
      'name' : 'Anil Store',
      'description' : 'Test Payment',
      'external':{
        'wallets':['paytm']
      }
    };
    try{
      _razorpay.open(options);
    }
    catch(e){
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: 'Success ${response.paymentId}');
  }
  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: 'Error: ${response.code.toString()}  ${response.message}');
  }
  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'External Wallet ${response.walletName}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment'),),
      body: FlatButton(child: Text('Confirm'),
      onPressed: (){
        openCheckOut();
      },),
      
    );
  }
}



