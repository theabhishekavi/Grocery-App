import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/database/address_helper.dart';
import 'package:shop/drawer/my_address_screen.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/payment/payment_page.dart';
import 'package:shop/utils/strings.dart';
// import 'package:permission_handler/permission_handler.dart';

class PickAddress extends StatefulWidget {
  static const routeName = '/PickAddress';

  @override
  _PickAddressState createState() => _PickAddressState();
}

class _PickAddressState extends State<PickAddress> {
  AddressHelper _addressHelper = AddressHelper();
  AddressModel _addressModel;

  TextEditingController _nameController,
      _localityController,
      _landmarkController,
      _pincodeController,
      _numberController;

  static var _initialLatitude, _initialLongitude;

  String addressLine = 'By Default';

  SharedPreferences sharedPreferences;

  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  initState() {
    super.initState();
    _initialLatitude = 25.227821;
    _initialLongitude = 86.981146;
    _nameController = TextEditingController(text: "");
    _localityController = TextEditingController(text: "");
    _landmarkController = TextEditingController(text: "");
    _pincodeController = TextEditingController(text: "");
    _numberController = TextEditingController(text: "");
    initializeSharedPreferences().then((_) {
      setState(() {});
    });
  }

  GoogleMapController _controller;

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  // PermissionStatus status;

  // void permission() async {
  //   status = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.locationWhenInUse);

  //   if (status == PermissionStatus.unknown) {
  //     await PermissionHandler()
  //         .requestPermissions([PermissionGroup.locationWhenInUse]);
  //   }

  //   status = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.locationWhenInUse);
  // }

  // Future<void> getUserAddress(LatLng location) async {
  //   final coordinates = new Coordinates(location.latitude, location.longitude);
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;

  //   addressLine =
  //       '${first.addressLine} and  ${first.locality} and ${first.featureName} and ${first.subLocality}';
  //   print(addressLine);
  // }

  // Future<void> getUserCordinates(String query) async {
  //   var addresses = await Geocoder.local.findAddressesFromQuery(query);
  //   var first = addresses.first;
  //   print("${first.featureName} : ${first.coordinates}");
  // }

  @override
  Widget build(BuildContext context) {
    // permission();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Address',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6.0),
              height: 300 - MediaQuery.of(context).viewInsets.bottom,
              width: double.infinity,
              color: Colors.grey[200],
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    onTap: (location) {
                      print(location.latitude);
                    },
                    zoomGesturesEnabled: false,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_initialLatitude, _initialLongitude),
                      zoom: 14.0,
                    ),
                    // onMapCreated: mapCreated,
                    markers: Set<Marker>.of(
                      <Marker>[
                        Marker(
                          // onTap: () {
                          //   InfoWindow(title: "Hold and Drag"); //not working
                          // },
                          draggable: true,
                          markerId: MarkerId('1'),
                          position: LatLng(_initialLatitude, _initialLongitude),
                          // onDragEnd: (location) {
                          //   _initialLatitude = location.latitude;
                          //   _initialLongitude = location.longitude;
                          //   getUserAddress(location);
                          // },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.my_location,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(labelText: 'Name'),
                          ),
                          TextField(
                            controller: _localityController,
                            decoration: InputDecoration(
                                labelText: 'Street/Area/Locality'),
                            // onSubmitted: (address) async {
                            //   await getUserCordinates(address);
                            // },
                          ),
                          TextField(
                            controller: _landmarkController,
                            decoration: InputDecoration(labelText: 'LandMark'),
                          ),
                          TextField(
                            controller: _pincodeController,
                            decoration: InputDecoration(labelText: 'Pincode'),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: _numberController,
                            decoration: InputDecoration(labelText: 'Ph.Number'),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(addressLine),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    child: Text('Add Address'),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_nameController.text == "" ||
                          _localityController.text == "" ||
                          _landmarkController.text == "" ||
                          _pincodeController.text == "" ||
                          _numberController.text == "") {
                      } else {
                        if (_pincodeController.text.length != 6) {
                          Fluttertoast.showToast(
                            msg: "Enter a valid pincode",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          );
                        } else if (_numberController.text.length != 10) {
                          Fluttertoast.showToast(
                            msg: "Phone Number should be of 10 digits",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          );
                        } else {
                          //All details are valid
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          List<String> defaultAddress = [
                            _nameController.text,
                            _localityController.text,
                            _landmarkController.text,
                            _pincodeController.text,
                            _numberController.text,
                          ];
                          String userId =
                              sharedPreferences.getString(StringKeys.userId);
                          if (sharedPreferences.containsKey(
                              userId + StringKeys.defaultAddressKey)) {
                            sharedPreferences
                                .remove(userId + StringKeys.defaultAddressKey);
                            sharedPreferences.setStringList(
                                userId + StringKeys.defaultAddressKey,
                                defaultAddress);
                          } else
                            sharedPreferences.setStringList(
                                userId + StringKeys.defaultAddressKey,
                                defaultAddress);
                          _addressModel = new AddressModel(
                            name: _nameController.text,
                            locality: _localityController.text,
                            landmark: _landmarkController.text,
                            phNumber: _numberController.text,
                            pincode: _pincodeController.text,
                          );
                          insertAddress(_addressModel);
                          Fluttertoast.showToast(
                            msg: "Address Added Successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                          );

                          Navigator.of(context)
                              .pushReplacementNamed(MyAddressScreen.routeName);
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> insertAddress(AddressModel addressItems) async {
    int result = await _addressHelper.insertAddress(addressItems);
    print(result);
  }
}
