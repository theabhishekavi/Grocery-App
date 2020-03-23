import 'package:flutter/material.dart';

class MyOrderScreen extends StatelessWidget {
  static const routeName = '/MyOrderScreenRouteName';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        title: Text('Anil Store'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'My Orders',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          
        ],
      ),
    );
  }
}
