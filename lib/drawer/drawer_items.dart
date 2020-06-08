import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/drawer/about_us.dart';
import 'package:shop/drawer/help_center.dart';
import 'package:shop/login/login_screen.dart';
import 'package:shop/login/logout_utils.dart';
import 'package:shop/models/profile_model.dart';
import './favourite_screen.dart';
import 'package:shop/orders/my_order_screen.dart';
import 'package:shop/profile/profile_screen.dart';
import '../utils/strings.dart';

class DrawerItems extends StatefulWidget {
  @override
  _DrawerItemsState createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  static const TextStyle optionStyleDrawer = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  SharedPreferences sharedPreferences;
  bool _isLoggedIn = false;

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  String _providerName, _providerDisplayName, _providerEmail;

  LogoutUtils _logoutUtils = LogoutUtils();

  String _userId;

  // bool _isFirebaseDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getDataFromFirebase().then((_) {
      if (this.mounted)
        setState(() {
          // _isFirebaseDataLoaded = true;
        });
    });
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
    }
  }

  // void getDataFromSharedPreferences() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.containsKey(StringKeys.isLoggedIn)) {
  //     _isLoggedIn = true;
  //     _providerName = sharedPreferences.getString(StringKeys.providerName);
  //     _userId = sharedPreferences.getString(StringKeys.userId);
  //     if (_providerName == StringKeys.providerKeyGoogle) {
  //       _providerDisplayName = sharedPreferences
  //           .getString(_userId + StringKeys.providerDisplayName);
  //       _providerEmail =
  //           sharedPreferences.getString(_userId + StringKeys.providerEmail);
  //     } else if (_providerName == StringKeys.providerKeyFacebook) {
  //       _providerDisplayName = sharedPreferences
  //           .getString(_userId + StringKeys.providerDisplayName);
  //       if ((sharedPreferences.getString(_userId + StringKeys.providerEmail)) !=
  //           null)
  //         _providerEmail =
  //             sharedPreferences.getString(_userId + StringKeys.providerEmail);
  //       else
  //         _providerEmail = "FACEBOOK USER";
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
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: (_isLoggedIn && _providerDisplayName != null)
                ? Text(
                    '$_providerDisplayName',
                    style: TextStyle(fontSize: 16),
                  )
                : Text('Guest User'),
            accountEmail: (_isLoggedIn && _providerEmail != null)
                ? Text('$_providerEmail')
                : Text('Guest Email'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                (_isLoggedIn && _providerDisplayName != null)
                    ? '${_providerDisplayName.substring(0, 1)}'
                    : 'G',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
          // : UserAccountsDrawerHeader(
          //     accountEmail: Text(""),
          //     accountName: Text(""),
          //   ),
          ListTile(
              title: Text(
                'My Account',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.account_circle),
              onTap: () {
                Navigator.of(context).pop();
                if (_isLoggedIn)
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                else {
                  Fluttertoast.showToast(msg: "Sign in to see your Profile");
                  Navigator.of(context)
                      .pushReplacementNamed(LoginPage.routeName);
                }
              }),
          ListTile(
            title: Text(
              'My Notifications',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.notifications_active),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
              title: Text(
                'My Orders',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.add_shopping_cart),
              onTap: () {
                Navigator.of(context).pop();
                if (_isLoggedIn)
                  Navigator.of(context).pushNamed(MyOrderScreen.routeName);
                else {
                  Fluttertoast.showToast(msg: "Sign in to see your Orders");
                  Navigator.of(context)
                      .pushReplacementNamed(LoginPage.routeName);
                }
              }),
          ListTile(
              title: Text(
                'Favourites',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(FavouritePage.routeName);
              }),
          ListTile(
            title: Text(
              'Rate App',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.rate_review),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
              title: Text(
                'Need Help',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return HelpCenter();
                    },
                  ),
                );
              }),
          ListTile(
            title: Text(
              'Share',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.share),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
              title: Text(
                'About',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AboutUs();
                }));
              }),
          ListTile(
              title: Text(
                'Logout',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.power_settings_new),
              onTap: () {
                if (_isLoggedIn) {
                  Navigator.of(context).pop();
                  _logoutUtils.logout(context, sharedPreferences);
                } else {
                  Fluttertoast.showToast(msg: "User not Logged In");
                }
              }),
        ],
      ),
    );
  }
}
