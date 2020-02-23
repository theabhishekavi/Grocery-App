import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/Screens/product_screen.dart';
import 'package:shop/location/pick_address.dart';
import 'package:shop/login/login_screen.dart';
import 'package:shop/payment/payment_page.dart';
import './login/phone_login_screen.dart';
import './home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        PaymentPage.routeName:(BuildContext context) => PaymentPage(),
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
