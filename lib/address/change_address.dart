import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/Screens/order_checkout_screen.dart';
import 'package:shop/database/address_helper.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/models/cart_items.dart';
import 'package:shop/utils/strings.dart';

class ChangeAddress extends StatefulWidget {
  //these three values are used to send it back to order checkout screen when change address is updated
  final List<CartItems> cartItemList;
  final double checkOutPrice;
  final bool emptyCart;

  ChangeAddress({this.cartItemList, this.checkOutPrice, this.emptyCart});

  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  List<AddressModel> _addressItemList = [];
  AddressHelper _addressHelper = AddressHelper();
  SharedPreferences sharedPreferences;
  List<String> defaultAddress = [];
  int selectedRadioTile = 0;
  String userId;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void initState() {
    super.initState();
    getAddressList().then((_) {
      if (this.mounted) {
        setState(() {
          _addressItemList = _addressItemList;
        });
      }
    });
  }

  Future<void> getAddressList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString(StringKeys.userId);
    defaultAddress =
        sharedPreferences.getStringList(userId + StringKeys.defaultAddressKey);
    _addressItemList = [];
    List<Map<String, dynamic>> list = await _addressHelper.getAddressList();
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> map = list[i];
      AddressModel addressModel = new AddressModel(
        name: map['addName'],
        landmark: map['addLandmark'],
        locality: map['addLocality'],
        phNumber: map['addPhoneNumber'],
        pincode: map['addPincode'],
      );
      _addressItemList.add(addressModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Address'),
      ),
      body: ListView.builder(
        itemCount: _addressItemList.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5.0,
              child: RadioListTile(
                value: index + 1,
                groupValue: selectedRadioTile,
                title: Text(
                  _addressItemList[index].name,
                  style: TextStyle(fontSize: 22),
                ),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
                selected: (selectedRadioTile == index + 1) ? true : false,
                activeColor: Theme.of(context).primaryColor,
                subtitle: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _addressItemList[index].locality,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _addressItemList[index].landmark,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _addressItemList[index].pincode,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _addressItemList[index].phNumber,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 50,
          child: RaisedButton(
            onPressed: () {
              if (checkSelectedAddressIsDefault(selectedRadioTile - 1)) {
                Fluttertoast.showToast(
                    msg: 'Selected address is same as current address');
              } else {
                defaultAddress = [
                  _addressItemList[selectedRadioTile - 1].name,
                  _addressItemList[selectedRadioTile - 1].locality,
                  _addressItemList[selectedRadioTile - 1].landmark,
                  _addressItemList[selectedRadioTile - 1].pincode,
                  _addressItemList[selectedRadioTile - 1].phNumber,
                ];
                sharedPreferences.remove(userId + StringKeys.defaultAddressKey);
                sharedPreferences.setStringList(
                    userId + StringKeys.defaultAddressKey, defaultAddress);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return OrderCheckout(
                    cartItemList: widget.cartItemList,
                    checkOutPrice: widget.checkOutPrice,
                    emptyCart: widget.emptyCart,
                  );
                }));
              }
            },
            child: Text(
              'Change Address',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  bool checkSelectedAddressIsDefault(int index) {
    if (_addressItemList[index].name == defaultAddress[0] &&
        _addressItemList[index].locality == defaultAddress[1] &&
        _addressItemList[index].landmark == defaultAddress[2] &&
        _addressItemList[index].pincode == defaultAddress[3] &&
        _addressItemList[index].phNumber == defaultAddress[4])
      return true;
    else
      return false;
  }
}
