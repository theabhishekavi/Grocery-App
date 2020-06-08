import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/database/address_helper.dart';
import 'package:shop/address/my_address_screen.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/utils/strings.dart';
import 'package:geolocator/geolocator.dart';

class PickAddress extends StatefulWidget {
  static const routeName = '/PickAddress';

  @override
  _PickAddressState createState() => _PickAddressState();
}

class _PickAddressState extends State<PickAddress> {
  AddressHelper _addressHelper = AddressHelper();
  AddressModel _addressModel;
  Position currentLocation;

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

  GoogleMapController _controller;
  Set<Polyline> _polyLine = HashSet<Polyline>();

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(25.2154, 86.9770));
    polylineLatLongs.add(LatLng(25.228469, 86.986870));
    polylineLatLongs.add(LatLng(25.236476, 86.983513));
    polylineLatLongs.add(LatLng(25.243920, 86.997812));

    polylineLatLongs.add(LatLng(25.253779, 87.000131));
    polylineLatLongs.add(LatLng(25.256496, 86.989027));
    polylineLatLongs.add(LatLng(25.250285, 86.972292));
    polylineLatLongs.add(LatLng(25.241591, 86.969432));
    polylineLatLongs.add(LatLng(25.233943, 86.973426));
    polylineLatLongs.add(LatLng(25.217211, 86.971154));
    polylineLatLongs.add(LatLng(25.2154, 86.9770));

    _polyLine.add(Polyline(
      polylineId: PolylineId("0"),
      points: polylineLatLongs,
      width: 1,
      color: Theme.of(context).primaryColor,
    ));
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
      _setPolylines();
      setState(() {});
    });
  }

  PermissionStatus status;

  Future<void> permission() async {
    status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    print(status);
    if (status == PermissionStatus.denied) {
      await PermissionHandler().requestPermissions([PermissionGroup.location]);
    }
  }

  Future<Position> getCurrentLocation() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

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
                    onMapCreated: _onMapCreated,
                    onTap: (location) {
                      setState(() {
                        _initialLatitude = location.latitude;
                        _initialLongitude = location.longitude;
                      });
                    },
                    zoomGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_initialLatitude, _initialLongitude),
                      zoom: 15.0,
                    ),
                    polylines: _polyLine,
                    markers: Set<Marker>.of(
                      <Marker>[
                        Marker(
                          draggable: false,
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
                      child: InkWell(
                        onTap: () async {
                          await permission();
                          currentLocation = await getCurrentLocation();
                          print(currentLocation.latitude);
                        },
                        child: Icon(
                          Icons.my_location,
                          size: 25,
                          color: Theme.of(context).primaryColor,
                        ),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Currently, we are accepting orders only in the region enclosed in the map. \n(PS: Zoom out to see the enclosed area)",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      softWrap: true,
                    ),
                  ),
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
