import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class PhoneLogin extends StatefulWidget {
  static const routeName = '/PhoneLogin';
  static String phoneNo, smsCode, verificationId;

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController _phonecontroller;

  @override
  void initState() {
    super.initState();
    _phonecontroller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your phone number'),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Container(
                //decorate here
                child: TextField(
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                ),
              ),
            ),
            RaisedButton(
              onPressed: verifyNumber,
              child: Text('Verify phone number'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyNumber() async {
    print('${_phonecontroller.text} is');
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      PhoneLogin.verificationId = verId;
    };

    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential credential) {
      print('verified');
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print(exception.message);
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      PhoneLogin.verificationId = verId;
      smsCodeDialog(context);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phonecontroller.text,
      verificationCompleted: verificationSuccess,
      verificationFailed: verificationFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
      timeout: const Duration(seconds: 5),
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter the Sms Code'),
            content: TextField(
              keyboardType: TextInputType.number,
              obscureText: true,
              onChanged: (value) {
                PhoneLogin.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              RaisedButton(
                color: Colors.teal,
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushReplacementNamed(HomePage.routeName);
                    } else {
                      Navigator.of(context).pop();
                      signIn(context);
                    }
                  });
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  signIn(BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: PhoneLogin.verificationId,
        smsCode: PhoneLogin.smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        if (user != null)
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      });
    } catch (e) {
      print(e);
    }
  }
}
