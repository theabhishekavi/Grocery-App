import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/ProfileScreenRouteName";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        title: Text('Anil Store'),
      ),
      body: SingleChildScrollView(
        child: Column(

          
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircleAvatar(backgroundColor: Colors.grey[200],radius: 80,)),
            ),
          ],
        ),
      ),
    );
  }
}
