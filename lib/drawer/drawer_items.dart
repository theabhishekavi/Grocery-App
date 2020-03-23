import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/login/login_screen.dart';
import './favourite_screen.dart';
import 'package:shop/drawer/my_order_screen.dart';
import 'package:shop/drawer/profile_screen.dart';
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

  String _providerName,
      _providerDisplayName,
      _providerEmail;

  String _userId;

  @override
  void initState() {
    super.initState();
    getDatatFromSharedPreferences();
  }

  void getDatatFromSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(StringKeys.isLoggedIn)) {
      _isLoggedIn = true;
      _providerName = sharedPreferences.getString(StringKeys.providerName);
      _userId = sharedPreferences.getString(StringKeys.userId);
      if (_providerName == StringKeys.providerKeyGoogle) {
        _providerDisplayName =
            sharedPreferences.getString(_userId+StringKeys.providerDisplayName);
        _providerEmail = sharedPreferences.getString(_userId+StringKeys.providerEmail);
      } 
      
      else if (_providerName == StringKeys.providerKeyFacebook) {
        _providerDisplayName =
            sharedPreferences.getString(_userId+StringKeys.providerDisplayName);
        if ((sharedPreferences.getString(_userId+StringKeys.providerEmail)) != null) 
          _providerEmail =
              sharedPreferences.getString(_userId+StringKeys.providerEmail);
         else 
          _providerEmail = "FACEBOOK USER";
        
      } 
      
      else if (_providerName == StringKeys.providerKeyEmailPassword) {
        if ((sharedPreferences.getString(_userId+StringKeys.providerDisplayName)) !=
            null)
          _providerDisplayName =
              sharedPreferences.getString(_userId+StringKeys.providerDisplayName);
        else
          _providerDisplayName = 'EMAIL USER';
        _providerEmail = sharedPreferences.getString(_userId+StringKeys.providerEmail);
      }
      
       else if (_providerName == StringKeys.providerKeyPhone) {

        if(sharedPreferences.getString(_userId+StringKeys.providerDisplayName)!=null){
           _providerDisplayName =
            sharedPreferences.getString(_userId+StringKeys.providerDisplayName);
        }else
        _providerDisplayName =
            sharedPreferences.getString(_userId+StringKeys.providerPhoneNumber);
        if(sharedPreferences.getString(_userId+StringKeys.providerEmail)!=null){
           _providerEmail =
            sharedPreferences.getString(_userId+StringKeys.providerEmail);
        }else 
        _providerEmail = 'PHONE USER';
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: (_isLoggedIn && _providerDisplayName != null)
                ? Text('$_providerDisplayName')
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
          ListTile(
              title: Text(
                'My Account',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.account_circle),
              onTap: () {
                Navigator.of(context).pop();
                if(_isLoggedIn)
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
                else{
                  Fluttertoast.showToast(msg: "Sign in to see your Profile");
                  Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
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
                if(_isLoggedIn)
                Navigator.of(context).pushNamed(MyOrderScreen.routeName);
                else{
                  Fluttertoast.showToast(msg: "Sign in to see your Orders");
                  Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
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
            onTap: () => Navigator.of(context).pop(),
          ),
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
              'Legals',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.comment),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text(
              'Logout',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.input),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
