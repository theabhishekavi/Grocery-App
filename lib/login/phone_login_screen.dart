import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home_page.dart';

class PhoneLogin extends StatefulWidget {
  static const routeName = '/PhoneLogin';
  static String phoneNo, smsCode, verificationId;

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController _phonecontroller;
  bool _loadState = false;

  @override
  void initState() {
    super.initState();
    _phonecontroller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = (_loadState)
        ? new Container(
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
          )
        : new Container();
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Verification'),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                child: Container(
                  //decorate here
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    controller: _phonecontroller,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                      contentPadding: EdgeInsets.all(0.0),
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  if (_phonecontroller.text.length != 10) {
                    Fluttertoast.showToast(
                        msg: "Enter a valid Ph.No without any +91/0");
                  } else {
                    setState(() {
                      
                      _loadState = true;
                    });
                    verifyNumber();
                  }
                },
                child: Text('Verify phone number'),
              ),
            ],
          ),
          new Align(
            child: loadingIndicator,
            alignment: FractionalOffset.bottomCenter,
          ),
        ],
      ),
    );
  }

  Future<void> verifyNumber() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      PhoneLogin.verificationId = verId;
    };

    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential credential) {
      FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        if (user != null){
          Fluttertoast.showToast(msg: 'Phone Log In Successful');
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
        else{
          Fluttertoast.showToast(msg: 'Log In Failed');
        }
          
      });
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
      phoneNumber: '+91${_phonecontroller.text}',
      verificationCompleted: verificationSuccess,
      verificationFailed: verificationFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
      timeout: const Duration(seconds: 5),
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    setState(() {
      _loadState = false;
    });
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Center(child: Text('Sms Code Sent Successfully!')),
            content: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter the Code',
                ),
                obscureText: true,
                onChanged: (value) {
                  PhoneLogin.smsCode = value;
                },
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  setState(() {
                    _loadState = true;
                  });
                  signIn(context).then((val) {
                    Navigator.of(context).pop();
                    if(val){
                      Fluttertoast.showToast(msg: 'Phone Log In Successful');
                       Navigator.of(context).pushReplacementNamed(HomePage.routeName);
                    }
                    else{
                      Fluttertoast.showToast(msg: 'Log In Failed');
                      setState(() {
                        _loadState = false;
                      });
                    }
                  });
                  // FirebaseAuth.instance.currentUser().then((user) {
                  //   if (user != null) {
                  //     print('not null ran');
                  //     Navigator.of(context).pop();
                  //     Navigator.of(context)
                  //         .pushReplacementNamed(HomePage.routeName);
                  //   } else {
                  //     print('null ran');
                  //     Navigator.of(context).pop();
                  //     signIn(context);
                  //   }
                  // });
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 100,
              ),
            ],
          );
        });
  }

  Future<bool> signIn(BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: PhoneLogin.verificationId,
        smsCode: PhoneLogin.smsCode,
      );
      AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      
        if (authResult != null) {
         return true;
        }
        else return false;
      
    } catch (e) {
      return false;
     
    }
  }
}
