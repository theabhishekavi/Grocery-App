import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/drawer/favourite_screen.dart';
import 'package:shop/drawer/my_address_screen.dart';
import 'package:shop/orders/my_order_screen.dart';
import 'package:shop/Screens/order_checkout_screen.dart';
import 'package:shop/Screens/product_detail_screen.dart';
import 'package:shop/Screens/product_screen.dart';
import 'package:shop/drawer/profile_screen.dart';
import 'package:shop/address/pick_address.dart';
import 'package:shop/login/login_screen.dart';
import 'package:shop/navigation_screens/cart.dart';

import './login/phone_login_screen.dart';
import './home_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        canvasColor: Colors.white,
        accentColor: Colors.red,
      ),
      routes: <String, WidgetBuilder>{
        HomePage.routeName: (BuildContext context) => HomePage(),
        ProductScreen.routeName: (BuildContext context) => ProductScreen(),
        LoginPage.routeName: (BuildContext context) => LoginPage(),
        PhoneLogin.routeName: (BuildContext context) => PhoneLogin(),
        PickAddress.routeName: (BuildContext context) => PickAddress(),
        CartPage.routeName: (BuildContext context) => CartPage(),
        FavouritePage.routeName: (BuildContext context) => FavouritePage(),
        ProfileScreen.routeName: (BuildContext context) => ProfileScreen(),
        ProductDetailScreen.routeName: (BuildContext context) =>
            ProductDetailScreen(),
        MyOrderScreen.routeName: (BuildContext context) => MyOrderScreen(),
        MyAddressScreen.routeName: (BuildContext context) => MyAddressScreen(),
        OrderCheckout.routeName: (BuildContext context) => OrderCheckout(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadScreen();
  }

  Future<Timer> loadScreen() async {
    return Timer(Duration(seconds: 1), _loadUI);
  }

  void _loadUI() async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSplashScreen(),
    );
  }

  Widget _showSplashScreen() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
