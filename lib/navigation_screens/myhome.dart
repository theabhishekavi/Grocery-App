import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/navigation_screens/categories.dart';

class MyHomePage extends StatelessWidget {
  final TextStyle myStyle = TextStyle(
    fontSize: 15,
  );
  final TextStyle myStyleSmall = TextStyle(
    fontSize: 12,
    color: Colors.grey[600],
  );

  final Widget imageCarousel = Container(
    height: 170,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/offer_images/o_image1.jpg'),
        AssetImage('assets/offer_images/o_image2.jpg'),
        AssetImage('assets/offer_images/o_image3.jpg'),
      ],
      dotSize: 4.0,
      dotSpacing: 15.0,
      dotColor: Colors.pink[300],
      indicatorBgPadding: 5.0,
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 3000),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            imageCarousel,
            CategoriesPage(),
          ],
        ),
      ),
    );
  }
}
