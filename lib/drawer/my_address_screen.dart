import 'package:flutter/material.dart';
import 'package:shop/database/address_helper.dart';
import 'package:shop/location/pick_address.dart';
import 'package:shop/models/address_model.dart';

class MyAddressScreen extends StatefulWidget {
  static const routeName = '/MyAddressScreenRouteName';
  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  List<AddressModel> _addressItemList = [];
  AddressHelper _addressHelper = AddressHelper();

  @override
  void initState() {
    super.initState();
    getAddressList().then((_) {
      setState(() {
        _addressItemList = _addressItemList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anil Store'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text(
                'My Addresses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'No. of Saved Addresses: ${_addressItemList.length}',
                    style: TextStyle(fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(PickAddress.routeName);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '+ Add Addresses',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              color: Colors.grey[300],
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _addressItemList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  (_addressItemList[index].name == null)
                                      ? ""
                                      : _addressItemList[index].name,
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  (_addressItemList[index].locality == null)
                                      ? ""
                                      : _addressItemList[index].locality,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  (_addressItemList[index].landmark == null)
                                      ? ""
                                      : _addressItemList[index].landmark,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  (_addressItemList[index].pincode == null)
                                      ? ""
                                      : _addressItemList[index].pincode,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  (_addressItemList[index].phNumber == null)
                                      ? ""
                                      : _addressItemList[index].phNumber,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: InkWell(
                                onTap: (){
                                  deleteAddress(_addressItemList[index]).then((_){
                                    setState(() {
                                      _addressItemList.removeAt(index);
                                    });

                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteAddress(AddressModel addressModel) async{
    await _addressHelper.deleteAddress(addressModel.name+addressModel.locality+addressModel.landmark+addressModel.phNumber);
  }

  Future<void> getAddressList() async {
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
  }
}
