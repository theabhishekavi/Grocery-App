import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/empty_images/no_offer.jpeg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Currently, no offers \n          Available",
              style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
