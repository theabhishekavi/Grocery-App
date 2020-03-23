import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/database/close_sql_database.dart';
import 'package:shop/drawer/drawer_items.dart';
import './login/logout_utils.dart';
import './utils/strings.dart';
import 'package:shop/login/login_screen.dart';
import './navigation_screens/cart.dart';
import './navigation_screens/categories.dart';
import './navigation_screens/myhome.dart';
import './navigation_screens/offers.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePageRoute';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyHomePage _myHomePage;
  CategoriesPage _categoriesPage;
  OffersPage _offersPage;
  CartPage _cartPage;

  List<Widget> pages;
  Widget currentPage;
  CloseAllSqlDatabase _closeAllSqlDatabase = CloseAllSqlDatabase();
  LogoutUtils _logoutUtils = LogoutUtils();

  int _selectedIndex = 0;
  bool _isLoggedIn = false;
  String _providerName,
      _providerDisplayName,
      _providerEmail,
      _providerPhoneNumber,
      _providerPhotoUrl;
  String _userId;

  SharedPreferences _preferences;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );

  @override
  void initState() {
    _myHomePage = MyHomePage();
    _categoriesPage = CategoriesPage();
    _offersPage = OffersPage();
    _cartPage = CartPage();

    pages = [_myHomePage, _categoriesPage, _offersPage, _cartPage];
    currentPage = _myHomePage;

    loginState();
    super.initState();
  }

  void loginState() async {
    _preferences = await SharedPreferences.getInstance();
    _firebaseUser = await _auth.currentUser();
   
    if (_firebaseUser != null) {
       _userId = _firebaseUser.uid;
      if (_firebaseUser.providerData[1].providerId == 'google.com') {
        _providerName = StringKeys.providerKeyGoogle;
        _providerDisplayName = _firebaseUser.displayName;
        _providerEmail = _firebaseUser.email;
        _providerPhotoUrl = _firebaseUser.photoUrl;
      } else if (_firebaseUser.providerData[1].providerId == 'facebook.com') {
        _providerName = StringKeys.providerKeyFacebook;
        _providerDisplayName = _firebaseUser.displayName;
        _providerPhotoUrl = _firebaseUser.photoUrl;
      } else if (_firebaseUser.providerData[1].providerId == 'phone') {
        _providerName = StringKeys.providerKeyPhone;
        _providerPhoneNumber = _firebaseUser.phoneNumber;
      } else if (_firebaseUser.providerData[1].providerId == 'password') {
        _providerName = StringKeys.providerKeyEmailPassword;
        _providerEmail = _firebaseUser.email;
      }
      _isLoggedIn = true;
      addIsLoggedIn();
    }
    setState(() {});
  }

  void addIsLoggedIn() async {
    _preferences.setBool(StringKeys.isLoggedIn, true);
    _preferences.setString(StringKeys.providerName, _providerName);
    _preferences.setString(StringKeys.userId, _userId);
    if (!_preferences.containsKey(_userId + StringKeys.providerDisplayName) &&
        !_preferences.containsKey(_userId + StringKeys.providerPhoneNumber) &&
        !_preferences.containsKey(_userId + StringKeys.providerEmail) &&
        !_preferences.containsKey(_userId + StringKeys.providerEmail)) {
      _preferences.setString(
          _userId + StringKeys.providerDisplayName, _providerDisplayName);
      _preferences.setString(
          _userId + StringKeys.providerEmail, _providerEmail);
      _preferences.setString(
          _userId + StringKeys.providerPhoneNumber, _providerPhoneNumber);
      _preferences.setString(
          _userId + StringKeys.providerPhotoUrl, _providerPhotoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     '$_isLoggedIn $_providerName $_providerDisplayName $_providerEmail $_providerPhoneNumber $_providerPhotoUrl $_userId');
    // if (_preferences != null)
    //   print('${_preferences.containsKey('isLoggedIn')}');
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          _closeAllSqlDatabase.close();
          return true;
        } else {
          setState(() {
            _selectedIndex = 0;
            currentPage = _myHomePage;
          });
          return false;
        }
      },
      child: Scaffold(
          body: currentPage,
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'HOME',
                  style: optionStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text(
                  'CATEGORIES',
                  style: optionStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                title: Text(
                  'Offers',
                  style: optionStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text(
                  'CART',
                  style: optionStyle,
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Theme.of(context).accentColor,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                currentPage = pages[index];
              });
            },
            type: BottomNavigationBarType.fixed,
          ),
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  _logoutUtils.logout(context, _preferences);
                },
              ),
            ],
            title: Text('Anil Store'),
          ),
          drawer: DrawerItems()),
    );
  }
}
