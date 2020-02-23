import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shop/payment/payment_page.dart';
// import 'package:permission_handler/permission_handler.dart';

class PickAddress extends StatefulWidget {
  static const routeName = '/PickAddress';

  @override
  _PickAddressState createState() => _PickAddressState();
}

class _PickAddressState extends State<PickAddress> {
  static var _initialLatitude = 25.227821;
  static var _initialLongitude = 86.981146;

  String addressLine = 'By Default';

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

  Future<void> getUserAddress(LatLng location) async {
    final coordinates = new Coordinates(location.latitude, location.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    addressLine =
        '${first.addressLine} and  ${first.locality} and ${first.featureName} and ${first.subLocality}';
    print(addressLine);
  }

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
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_initialLatitude, _initialLongitude),
                      zoom: 14.0,
                    ),
                    onMapCreated: mapCreated,
                    markers: Set<Marker>.of(
                      <Marker>[
                        Marker(
                          onTap: () {
                            InfoWindow(title: "Hold and Drag"); //not working
                          },
                          draggable: true,
                          markerId: MarkerId('1'),
                          position: LatLng(_initialLatitude, _initialLongitude),
                          onDragEnd: (location) {
                            _initialLatitude = location.latitude;
                            _initialLongitude = location.longitude;
                            getUserAddress(location);
                          },
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
                        size: 20,
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
                            decoration: InputDecoration(labelText: 'Name'),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                labelText: 'Street/Area/Locality'),
                            // onSubmitted: (address) async {
                            //   await getUserCordinates(address);
                            // },
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'LandMark'),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Pincode'),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Ph:No'),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(addressLine),
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
                      Navigator.of(context).pushNamed(PaymentPage.routeName);
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
}
