import 'package:flutter/material.dart';
import 'package:shop/models/product_type.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/ProductDetailScreenRouteName';
  ProductModel productModel;
  List<ProductModel> productList;
  ProductDetailScreen({this.productModel,this.productList});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  
  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anil Store'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 200,
                    child: FittedBox(
                      child: Image.network(
                        widget.productModel.productImage,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Icon(
                    Icons.favorite,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.productModel.productName,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Row(
                children: <Widget>[
                  Card(
                    elevation: 3,
                    child: Text(
                      'Rs. ${widget.productModel.productMrp}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  (widget.productModel.productMrp !=
                          widget.productModel.productSp)
                      ? Row(
                          children: <Widget>[
                            Text(
                              'Rs. ${widget.productModel.productSp}',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${discountPer(widget.productModel.productMrp, widget.productModel.productSp)}% off',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16),
                            ),
                          ],
                        )
                      : Padding(padding: EdgeInsets.all(0.0))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Offer - Buy 5 get 20% off',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Highlights  ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  'Share this Item! ',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Ratings',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Questions & Answers',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Ask a Question',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Similiar Products',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            GridView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.network(
                          widget.productList[0].productImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.productList[0].productName,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.network(
                          widget.productList[1].productImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.productList[1].productName,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.network(
                          widget.productList[2].productImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.productList[2].productName,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.network(
                          widget.productList[3].productImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.productList[3].productName,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.network(
                          widget.productList[4].productImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.productList[4].productName,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.network(
                          widget.productList[0].productImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.productList[0].productName,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'VIEW MORE',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey[100],
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.shopping_basket,color: Colors.blue,),
                      SizedBox(width: 5,),
                      Text("Buy Now",style: TextStyle(color: Colors.blue),),
                    ],
                  ),
                ),
                VerticalDivider(),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                    children: <Widget>[
                      Icon(Icons.shopping_cart,color: Colors.blue,),
                      SizedBox(width: 5,),
                      Text("Add to Cart",style: TextStyle(color: Colors.blue),),
                    ],
                ),
                 ),
              ],
            ),
          ),
        ),
        // child: Row(
        //   children: <Widget>[
        //     Column(
        //       children: <Widget>[
        //         Icon(Icons.shopping_basket),
        //         Text('Buy Now'),
        //       ],
        //     ),
        //     Column(
        //       children: <Widget>[
        //         Icon(Icons.shopping_basket),
        //         Text('Buy Now'),
        //       ],
        //     ),
        //   ],
        // ),
        elevation: 0.0,
      ),
      // BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_basket),
      //       title: Text(
      //         'Buy Now',
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_shopping_cart),
      //       title: Text(
      //         'Add to Cart',
      //       ),
      //     ),
    );
  }
}
