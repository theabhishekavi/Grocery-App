import 'package:flutter/material.dart';
import 'package:shop/location/pick_address.dart';
import 'package:shop/models/cart_items.dart';
import '../location/pick_address.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static List<CartItems> cartItemList = [
    CartItems(
        pImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        pCountOrdered: 2,
        pMrp: 30,
        pSp: 27,
        pName: 'Bread',
        pQuantity: '1',
        pCategoryName: 'Bread Jam'),
    CartItems(
        pImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        pCountOrdered: 1,
        pMrp: 30,
        pSp: 27,
        pName: 'Badam',
        pQuantity: '200gm',
        pCategoryName: 'Dry Fruits'),
    CartItems(
        pImage: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
        pCountOrdered: 1,
        pMrp: 300,
        pSp: 270,
        pName: 'Daaru',
        pQuantity: '250ml',
        pCategoryName: 'Whisky'),
        
  ];
  static double calPrice(List<CartItems> cartItemList) {
    double _sum = 0.0;
    for (int i = 0; i < cartItemList.length; i++) {
      _sum += cartItemList[i].pSp * cartItemList[i].pCountOrdered;
    }
    return _sum;
  }

  double _checkoutPrice = calPrice(cartItemList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.grey[700]),
        ),
        backgroundColor: Colors.grey[300],
        actions: <Widget>[
          FlatButton(
            color: Colors.grey[700],
            onPressed: () {
              Navigator.of(context).pushNamed(PickAddress.routeName);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('CHECKOUT'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Rs $_checkoutPrice',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartItemList.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    child: Image.network(cartItemList[index].pImage),
                  ),
                  title: Text(cartItemList[index].pName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(cartItemList[index].pCategoryName),
                      Text('Quantity: ${cartItemList[index].pQuantity}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rs ${cartItemList[index].pMrp * cartItemList[index].pCountOrdered}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        'Rs ${cartItemList[index].pSp * cartItemList[index].pCountOrdered}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Theme.of(context).accentColor, width: 1.0),
                        ),
                        width: 70,
                        height: 24,
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
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
                              '${cartItemList[index].pCountOrdered}',
                              style: TextStyle(
                                  fontSize: 13, ),
                            ),
                            VerticalDivider(
                              width: 10,
                              thickness: 1,
                              color: Theme.of(context).accentColor,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
