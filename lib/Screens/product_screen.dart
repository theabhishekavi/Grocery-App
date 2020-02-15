import 'package:flutter/material.dart';
import 'package:shop/models/product_type.dart';

class ProductScreen extends StatefulWidget {
  final String categoryType;
  final String categoryName;
  ProductScreen({this.categoryType, this.categoryName});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModel> productList = [
    ProductModel(
        productName: 'Bread',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Jam',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Toast',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Brea',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Butter',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Bread',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Bre',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Bread',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Jam',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Toast',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Brea',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Butter',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Bread',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
    ProductModel(
        productName: 'Bre',
        productImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        productAvailability: 100,
        productSp: 27,
        productCountOrdered: 0,
        productMrp: 30,
        productQuantity: '1'),
  ];
  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  int _productCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryType),
        actions: <Widget>[
          Icon(Icons.shopping_cart),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 3,
          ),
          Center(
            child: Text(
              widget.categoryName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.network(
                                productList[index].productImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(productList[index].productName),
                                Row(
                                  children: <Widget>[
                                    Text('Rs ${productList[index].productSp}'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${productList[index].productMrp}',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${discountPer(productList[index].productMrp, productList[index].productSp)}% off',
                                      style: TextStyle(
                                          color: Colors.lightGreen[300]),
                                    ),
                                  ],
                                ),
                                Text(
                                    'Quantity : ${productList[index].productQuantity}'),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Theme.of(context).accentColor,
                                  width: 1.0,
                                ),
                              ),
                              width: 70,
                              height: 30,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      if (productList[index]
                                              .productCountOrdered >
                                          0) {
                                        setState(() {
                                          productList[index]
                                              .productCountOrdered--;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 10,
                                    thickness: 1,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Text(
                                    '${productList[index].productCountOrdered}',
                                    style: TextStyle(
                                        fontSize: 13,),
                                  ),
                                  VerticalDivider(
                                    width: 10,
                                    thickness: 1,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (productList[index]
                                              .productCountOrdered <
                                          5) {
                                        setState(() {
                                          productList[index]
                                              .productCountOrdered++;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
