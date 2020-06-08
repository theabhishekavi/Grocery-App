import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Screens/product_screen.dart';
import 'package:shop/home_page.dart';
import 'package:shop/models/favourite_items.dart';
import '../database/favourite_helper.dart';

class FavouritePage extends StatefulWidget {
  static const routeName = '/FavouritePageRouteName';
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<FavouriteItems> favItemList = [];
  FavouriteHelper _favouriteHelper = new FavouriteHelper();

  Future<void> getFavouriteItem() async {
    favItemList = [];
    List<Map<String, dynamic>> favlist =
        await _favouriteHelper.getFavouriteMapList();
    for (int i = 0; i < favlist.length; i++) {
      Map<String, dynamic> map = favlist[i];
      FavouriteItems x = new FavouriteItems(
        categoryType: map['categoryType'],
        productName: map['productName'],
        productQuantity: map['productQuantity'],
        productAvailability: int.parse(map['productAvailability']),
        productImage: map['productImage'],
        productMrp: int.parse(map['productMrp']),
        productSp: int.parse(map['productSp']),
      );

      if (!favItemList.contains(x)) favItemList.add(x);
    }
  }

  int discountPer(int mrp, int sp) {
    double res = (mrp - sp) / mrp * 100.0;
    return res.round();
  }

  @override
  void initState() {
    super.initState();
    getFavouriteItem().then((_) {
      setState(() {
        favItemList = favItemList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        title: Text('Favourites'),
      ),
      body: (favItemList.length == 0)
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Your Favourite list is Empty",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Add products that you like in your favourite list'),
                SizedBox(
                  height: 5,
                ),
                Text('Review them and move to your cart anytime'),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Shop Now",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14),
                      ),
                    ),
                  ),
                )
              ],
            ))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: favItemList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8, crossAxisCount: 2),
                        itemBuilder: (ctx, index) {
                          return Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 5.0,
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                          return ProductScreen(
                                            categoryType:
                                                favItemList[index].categoryType,
                                          );
                                        }));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundColor: Colors.grey[300],
                                            backgroundImage: NetworkImage(
                                                favItemList[index]
                                                    .productImage),
                                            radius: 50,
                                          ),
                                          Text(
                                            favItemList[index].productName,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            favItemList[index].categoryType,
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                  'Rs ${favItemList[index].productSp}'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${favItemList[index].productMrp}',
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${discountPer(favItemList[index].productMrp, favItemList[index].productSp)}% off',
                                                style: TextStyle(
                                                    color:
                                                        Colors.lightGreen[300]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: InkWell(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Item removed from Favourite list');
                                    _favouriteHelper.deleteFavouriteItem(
                                        favItemList[index].productName +
                                            favItemList[index].categoryType +
                                            favItemList[index].productQuantity);
                                    favItemList.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    size: 25,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
