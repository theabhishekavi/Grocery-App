import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/address/my_address_screen.dart';
import 'package:shop/login/logout_utils.dart';
import 'package:shop/models/profile_model.dart';
import 'package:shop/orders/my_order_screen.dart';
import 'package:shop/database/address_helper.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/profile/question_answer.dart';
import 'package:shop/profile/ratings.dart';
import 'package:shop/utils/strings.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/ProfileScreenRouteName";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<AddressModel> _addressItemList = [];
  AddressHelper _addressHelper = AddressHelper();

  SharedPreferences sharedPreferences;
  LogoutUtils _logoutUtils = LogoutUtils();

  bool _isLoggedIn = false;

  TextEditingController _nameController = TextEditingController(text: "");
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _phoneNumberController =
      TextEditingController(text: "");

  String _providerName,
      _providerDisplayName,
      _providerEmail,
      _providerPhotoUrl,
      _providerPhoneNumber,
      _userId;

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  bool _isFirebaseDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getFirstAddress().then((_) {
      setState(() {
        _addressItemList = _addressItemList;
        _isFirebaseDataLoaded = true;
      });
    });
  }

  Future<void> getFirstAddress() async {
    _addressItemList = [];
    List<Map<String, dynamic>> list = await _addressHelper.getAddressList();
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> map = list[i];
      AddressModel addressModel = new AddressModel(
          name: map['addName'],
          landmark: map['addLandmark'],
          locality: map['addLocality'],
          phNumber: map['addPhoneNumber'],
          pincode: map['addPincode']);
      _addressItemList.add(addressModel);
    }
    await getDataFromFirebase();
  }

  Future<void> getDataFromFirebase() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(StringKeys.isLoggedIn)) {
      _isLoggedIn = true;
      _providerName = sharedPreferences.getString(StringKeys.providerName);
      _userId = sharedPreferences.getString(StringKeys.userId);
      await databaseReference
          .child("users")
          .child(_userId)
          .child("profile")
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = Map<dynamic, dynamic>();
        map = snapshot.value;
        ProfileModel profileModel = ProfileModel();
        profileModel.fromMap(map);
        _providerDisplayName = profileModel.providerDisplayName;
        _providerEmail = profileModel.providerEmail;
        _providerPhoneNumber = profileModel.providerPhoneNumber;
        _providerPhotoUrl = profileModel.providerPhotoUrl;

        if (_providerDisplayName == null) {
          if (_providerName == StringKeys.providerKeyEmailPassword) {
            _providerDisplayName = "EMAIL USER";
          } else if (_providerName == StringKeys.providerKeyPhone) {
            _providerDisplayName = profileModel.providerPhoneNumber;
          }
        } else if (_providerEmail == null) {
          if (_providerName == StringKeys.providerKeyFacebook) {
            _providerEmail = "FACEBOOK USER";
          } else if (_providerName == StringKeys.providerKeyPhone) {
            _providerEmail = "PHONE USER";
          }
        }
      });
      // setState(() {});
    }
  }

  // void getDataFromSharedPreferences() async {
  //   sharedPreferences = await SharedPreferences.getInstance();

  //   if (sharedPreferences.containsKey(StringKeys.isLoggedIn)) {
  //     _isLoggedIn = true;
  //     _providerName = sharedPreferences.getString(StringKeys.providerName);
  //     _userId = sharedPreferences.getString(StringKeys.userId);
  //     _providerPhoneNumber =
  //         sharedPreferences.getString(_userId + StringKeys.providerPhoneNumber);

  //     if (_providerName == StringKeys.providerKeyGoogle) {
  //       _providerDisplayName = sharedPreferences
  //           .getString(_userId + StringKeys.providerDisplayName);
  //       _providerEmail =
  //           sharedPreferences.getString(_userId + StringKeys.providerEmail);
  //       _providerPhotoUrl =
  //           sharedPreferences.getString(_userId + StringKeys.providerPhotoUrl);
  //     } else if (_providerName == StringKeys.providerKeyFacebook) {
  //       _providerDisplayName = sharedPreferences
  //           .getString(_userId + StringKeys.providerDisplayName);

  //       if ((sharedPreferences.getString(_userId + StringKeys.providerEmail)) !=
  //           null)
  //         _providerEmail =
  //             sharedPreferences.getString(_userId + StringKeys.providerEmail);
  //       else
  //         _providerEmail = "FACEBOOK USER";

  //       _providerPhotoUrl =
  //           sharedPreferences.getString(_userId + StringKeys.providerPhotoUrl);
  //     } else if (_providerName == StringKeys.providerKeyEmailPassword) {
  //       if ((sharedPreferences
  //               .getString(_userId + StringKeys.providerDisplayName)) !=
  //           null)
  //         _providerDisplayName = sharedPreferences
  //             .getString(_userId + StringKeys.providerDisplayName);
  //       else
  //         _providerDisplayName = 'EMAIL USER';
  //       _providerEmail =
  //           sharedPreferences.getString(_userId + StringKeys.providerEmail);
  //     } else if (_providerName == StringKeys.providerKeyPhone) {
  //       if (sharedPreferences
  //               .getString(_userId + StringKeys.providerDisplayName) !=
  //           null) {
  //         _providerDisplayName = sharedPreferences
  //             .getString(_userId + StringKeys.providerDisplayName);
  //       } else
  //         _providerDisplayName = sharedPreferences
  //             .getString(_userId + StringKeys.providerPhoneNumber);
  //       if (sharedPreferences.getString(_userId + StringKeys.providerEmail) !=
  //           null) {
  //         _providerEmail =
  //             sharedPreferences.getString(_userId + StringKeys.providerEmail);
  //       } else
  //         _providerEmail = 'PHONE USER';
  //     }
  //     // setState(() {});
  //   }
  // }

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
        title: Text('Anil Store'),
      ),
      body: SingleChildScrollView(
        child: (_isFirebaseDataLoaded == false)
            ? Center(child: loadingIndicator)
            : Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.blueAccent[400],
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              (_providerPhotoUrl != null)
                                  ? CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(_providerPhotoUrl),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      child: Icon(
                                        Icons.person_outline,
                                        size: 50,
                                      ),
                                      radius: 60,
                                    ),
                              (_providerDisplayName == null)
                                  ? Container()
                                  : Text(
                                      _providerDisplayName,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                              Column(
                                children: <Widget>[
                                  (_providerPhoneNumber == null)
                                      ? Container()
                                      : Text(
                                          _providerPhoneNumber,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                  (_providerEmail == null)
                                      ? Container()
                                      : Text(
                                          _providerEmail,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                ],
                              ),
                            ],
                          )),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: InkWell(
                          onTap: () {
                            editProfileDialog(context);
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey[400],
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 110,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'My Orders',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black87,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(MyOrderScreen.routeName);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0, right: 20.0),
                                        child: Text(
                                          'VIEW ALL ORDERS',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            // height: 110,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'My Addresses',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                (_addressItemList.length != 0)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 10.0),
                                        child: Text(
                                          '${_addressItemList[0].locality.substring(0, min(50, _addressItemList[0].locality.length))}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(0.0),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black87,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(MyAddressScreen.routeName);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 10.0,
                                            right: 20.0),
                                        child: Text(
                                          'VIEW ALL ADDRESSES',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 110,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'My Ratings',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black87,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Fluttertoast.showToast(msg: 'tapped');
                                   Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return MyRatings();
                                    }));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0, right: 20.0),
                                        child: Text(
                                          'VIEW YOUR RATINGS',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 110,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Question & Answers',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black87,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return QuestionAnswer();
                                    }));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0, right: 20.0),
                                        child: Text(
                                          'VIEW Q&A',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
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
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(20.0))),
                          child: FlatButton(
                            child: Text(
                              'LOGOUT',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _logoutUtils.logout(context, sharedPreferences);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Future<void> editProfileDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Edit Your Profile Details',
              textAlign: TextAlign.center,
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            actions: <Widget>[
              Container(
                width: 480,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('CANCEL'),
                      color: Theme.of(context).primaryColor,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        if (_providerName == StringKeys.providerKeyGoogle) {
                          if (_phoneNumberController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Enter the Phone Number');
                          } else {
                            if (_phoneNumberController.text.length != 10) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Enter a valid phone Number(10 digits Only)');
                            }
                            if (_phoneNumberController.text.length == 10) {
                              // sharedPreferences.setString(
                              //     _userId + StringKeys.providerPhoneNumber,
                              //     _phoneNumberController.text);
                              await databaseReference
                                  .child("users")
                                  .child(_userId)
                                  .child("profile")
                                  .child(StringKeys.providerPhoneNumber)
                                  .set(_phoneNumberController.text);
                              Fluttertoast.showToast(
                                  msg: 'Profile Updated Successfully!');
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(
                                  ProfileScreen.routeName);
                            }
                          }
                        }
                        if (_providerName == StringKeys.providerKeyFacebook) {
                          if (_phoneNumberController.text.isEmpty ||
                              _emailController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Enter the complete Details');
                          } else {
                            if (_phoneNumberController.text.length != 10) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Enter a valid phone Number(10 digits Only)');
                            }
                            if (_phoneNumberController.text.length == 10) {
                              // sharedPreferences.setString(
                              //     _userId + StringKeys.providerPhoneNumber,
                              //     _phoneNumberController.text);
                              // sharedPreferences.setString(
                              //     _userId + StringKeys.providerEmail,
                              //     _emailController.text);
                              await databaseReference
                                  .child("users")
                                  .child(_userId)
                                  .child("profile")
                                  .child(StringKeys.providerPhoneNumber)
                                  .set(_phoneNumberController.text);
                              await databaseReference
                                  .child("users")
                                  .child(_userId)
                                  .child("profile")
                                  .child(StringKeys.providerEmail)
                                  .set(_emailController.text);
                              Fluttertoast.showToast(
                                  msg: 'Profile Updated Successfully!');
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(
                                  ProfileScreen.routeName);
                            }
                          }
                        }
                        if (_providerName ==
                            StringKeys.providerKeyEmailPassword) {
                          if (_phoneNumberController.text.isEmpty ||
                              _nameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Enter the complete Details');
                          } else {
                            if (_phoneNumberController.text.length != 10) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Enter a valid phone Number(10 digits Only)');
                            }
                            if (_phoneNumberController.text.length == 10) {
                              // sharedPreferences.setString(
                              //     _userId + StringKeys.providerPhoneNumber,
                              //     _phoneNumberController.text);
                              // sharedPreferences.setString(
                              //     _userId + StringKeys.providerDisplayName,
                              //     _nameController.text);

                              await databaseReference
                                  .child("users")
                                  .child(_userId)
                                  .child("profile")
                                  .child(StringKeys.providerPhoneNumber)
                                  .set(_phoneNumberController.text);
                              await databaseReference
                                  .child("users")
                                  .child(_userId)
                                  .child("profile")
                                  .child(StringKeys.providerDisplayName)
                                  .set(_nameController.text);

                              Fluttertoast.showToast(
                                  msg: 'Profile Updated Successfully!');
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(
                                  ProfileScreen.routeName);
                            }
                          }
                        }
                        if (_providerName == StringKeys.providerKeyPhone) {
                          if (_emailController.text.isEmpty ||
                              _nameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Enter the complete Details');
                          } else {
                            // sharedPreferences.setString(
                            //     _userId + StringKeys.providerEmail,
                            //     _emailController.text);
                            // sharedPreferences.setString(
                            //     _userId + StringKeys.providerDisplayName,
                            //     _nameController.text);

                            await databaseReference
                                .child("users")
                                .child(_userId)
                                .child("profile")
                                .child(StringKeys.providerEmail)
                                .set(_emailController.text);
                            await databaseReference
                                .child("users")
                                .child(_userId)
                                .child("profile")
                                .child(StringKeys.providerDisplayName)
                                .set(_nameController.text);
                            Fluttertoast.showToast(
                                msg: 'Profile Updated Successfully!');
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed(ProfileScreen.routeName);
                          }
                        }
                      },
                      child: Text('CONFIRM'),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              )
            ],
            content: Container(
              width: 500,
              height: 200,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  'UserName:',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 3,
                                child: (_providerName ==
                                            StringKeys
                                                .providerKeyEmailPassword ||
                                        _providerName ==
                                            StringKeys.providerKeyPhone)
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                                hintText: _providerDisplayName,
                                                hintStyle: TextStyle(
                                                    color: Colors.black54),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      )
                                    : (_providerDisplayName != null)
                                        ? Text(_providerDisplayName)
                                        : Text(""),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Phone-Number:',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 3,
                                child: (_providerName !=
                                        StringKeys.providerKeyPhone)
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _phoneNumberController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: _providerPhoneNumber,
                                                hintStyle: TextStyle(
                                                    color: Colors.black54),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      )
                                    : (_providerPhoneNumber != null)
                                        ? Text(_providerPhoneNumber)
                                        : Text(""),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Email-ID',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 3,
                                child: (_providerName ==
                                            StringKeys.providerKeyFacebook ||
                                        _providerName ==
                                            StringKeys.providerKeyPhone)
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                                hintText: _providerEmail,
                                                hintStyle: TextStyle(
                                                    color: Colors.black54),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      )
                                    : (_providerEmail != null)
                                        ? Text(_providerEmail)
                                        : Text(""),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
