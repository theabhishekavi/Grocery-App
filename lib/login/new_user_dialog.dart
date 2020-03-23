import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './auth_provider.dart';

class NewUserDialog {
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passController = TextEditingController(text: '');
  TextEditingController _rePassController = TextEditingController(text: '');
  TextEditingController _forgotPasswordController =
      TextEditingController(text: '');

  Future<bool> newUserDialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            title: Text(
              "NEW USER",
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 180,
              width: 600,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .2),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: _passController,
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.alternate_email),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: _rePassController,
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Re-Password',
                              prefixIcon: Icon(Icons.alternate_email),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            actions: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        if(_passController.text==""||_rePassController.text==""|| _emailController.text==""){
                          Fluttertoast.showToast(msg: 'Enter all the above details');
                        }
                        else if(_passController.text != _rePassController.text){
                          Fluttertoast.showToast(msg: 'Password mismatch');
                        }
                        else if (_passController.text == _rePassController.text)
                          AuthProvider().signUpWithEmail(
                              _emailController.text, _passController.text).then((val){
                                if(val){
                                  Fluttertoast.showToast(msg: 'Signed Up Successfully!');
                                  Navigator.of(context).pop();
                                }
                                else{
                                  Fluttertoast.showToast(msg: 'Error in signing up, Please try again!');
                                  Navigator.of(context).pop();
                                }

                              });
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 250,
              )
            ],
          );
        });
  }

  Future<bool> forgotPasswordDialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: Container(
              width: 400,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              child: TextField(
                controller: _forgotPasswordController,
               
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_forgotPasswordController.text == "") {
                          Fluttertoast.showToast(msg: "First enter an email id");
                        } else {
                          AuthProvider()
                              .resetPassword(_forgotPasswordController.text)
                              .then((val) {
                            if (val) {
                              Fluttertoast.showToast(msg: "A link has been sent succesfully to ${_forgotPasswordController.text}");
                              Navigator.of(context).pop();
                              }
                              else{
                                 Fluttertoast.showToast(msg: "Enter a valid email id");
                              }
                          });
                        }
                      },
                      child: Text(
                        'RESET',
                        style: TextStyle(color: Colors.white),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 110,
              )
            ],
          );
        });
  }
}
