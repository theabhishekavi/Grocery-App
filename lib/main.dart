import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop/Screens/product_screen.dart';
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
        '/homePage': (BuildContext context) => HomePage(),
        '/ProductScreen':(BuildContext context) => ProductScreen(),
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
    return Timer(Duration(seconds: 3), _loadUI);
  }

  void _loadUI() async {
    Navigator.of(context).pushReplacementNamed('/homePage');
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
          image: AssetImage('assets/images/splash.jpg'),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
