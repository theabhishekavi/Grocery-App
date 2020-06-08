import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop/Screens/product_detail_screen.dart';
import 'package:shop/models/product_quantity_variant.dart';

class SearchProducts extends StatefulWidget {
  static const routeName = '/SearchProductsRouteName';
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  List<String> topSearches = [];
  final TextEditingController _searchQuery = new TextEditingController();
  List<List<ProductTight>> productList = [];
  bool _isLoadingProductList;
  bool _isSearching;
  String _searchText = "";
  List<String> productNames = [];
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  void intializeTopSearches() {
    topSearches = [
      "Horlicks",
      "Cerelac",
      "Maggie",
      "Mangal Oil",
      "Dabur Honey"
    ];
  }

  _SearchProductsState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _isLoadingProductList = true;
    intializeTopSearches();
    gettingProductListFromDatabase().then((_) {
      getProductNames(productList);
      print(productNames.length);
      setState(() {
        _isLoadingProductList = false;
      });
    });
  }

  void getProductNames(List<List<ProductTight>> product) {
    for (int i = 0; i < product.length; i++) {
      for (int j = 0; j < product[i].length; j++) {
        String nameAndQuantity =
            product[i][j].productName + "\n" + product[i][j].productQuantity;
        productNames.add(nameAndQuantity);
      }
    }
  }

  List<dynamic> getProductTightAndListForNavigation(
      String productName, String productQuantity) {
    List<dynamic> result = [];
    for (int i = 0; i < productList.length; i++) {
      List<ProductTight> tempList = [];
      bool x = false;
      ProductTight selectedProduct;
      for (int j = 0; j < productList[i].length; j++) {
        tempList.add(productList[i][j]);
        if (productList[i][j].productName == productName &&
            productList[i][j].productQuantity == productQuantity) {
          x = true;
          selectedProduct = productList[i][j];
        }
      }
      if (x) {
        result.add(selectedProduct);
        result.add(tempList);
        break;
      }
    }
    return result;
  }

  Future<void> gettingProductListFromDatabase() async {
    String catTypeName;
    String categoryName;
    String productName, productImage, productDetails, productQuantity;
    int productMrp, productSp, productAvailability, productCount;
    String productImage2, productImage3;
    int productOfferQuantity,
        productOfferDiscountPercentage,
        productOfferDiscountRupees;
    await databaseReference
        .child('categories')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((catTypeKey, catTypevalue) {
        catTypeName = catTypeKey;
        for (int j = 1; j < catTypevalue.length; j++) {
          Map<dynamic, dynamic> val1 = catTypevalue['$j'];
          categoryName = val1['category_name'];
          List<dynamic> productval1 = val1['products'];
          List<ProductTight> innerProductList = [];
          for (int i = 1; i < productval1.length; i++) {
            productName = productval1[i]['product_name'];
            productImage = productval1[i]['product_image'];
            productDetails = productval1[i]['product_details'];
            if (productval1[i]['product_quantity'] is String) {
              productSp = productval1[i]['product_sp'];
              productQuantity = productval1[i]['product_quantity'];
              productMrp = productval1[i]['product_mrp'];
              productAvailability = productval1[i]['product_availability'];
              productCount = productval1[i]['product_count'];
              productImage2 = productval1[i]['product_image2'];
              productImage3 = productval1[i]['product_image3'];
              productOfferQuantity = productval1[i]['product_offer_quantity'];
              productOfferDiscountPercentage =
                  productval1[i]['product_offer_discount_percentage'];
              productOfferDiscountRupees =
                  productval1[i]['product_offer_discount_rupees'];
              ProductTight productTight = ProductTight(
                categoryType: catTypeName,
                categoryName: categoryName,
                productName: productName,
                productImage: productImage,
                productDetails: productDetails,
                productSp: productSp,
                productQuantity: productQuantity,
                productMrp: productMrp,
                productCountOrdered: 0,
                productIsFav: false,
                productAvailability: productAvailability,
                productCount: productCount,
                productImage2: productImage2,
                productImage3: productImage3,
                productOfferQuantity: productOfferQuantity,
                productOfferDiscountPercentage: productOfferDiscountPercentage,
                productOfferDiscountRupees: productOfferDiscountRupees,
              );
              innerProductList.add(productTight);
            }
          }
          productList.add(innerProductList);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
    return Scaffold(
      body: (_isLoadingProductList)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    loadingIndicator,
                  ],
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _handleSearchStart();
                              },
                              child: TextField(
                                controller: _searchQuery,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Search Products',
                                  prefixIcon: Icon(Icons.search),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  (_isSearching)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.all(5.0),
                            shrinkWrap: true,
                            itemCount: _buildSearchList().length,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  List<dynamic> result =
                                      getProductTightAndListForNavigation(
                                          _buildSearchList()[index]
                                              .split("\n")[0],
                                          _buildSearchList()[index]
                                              .split("\n")[1]);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return ProductDetailScreen(
                                          productTight: result[0],
                                          productTightList: result[1],
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(2.0),
                                  title: Row(
                                    children: <Widget>[
                                      Icon(Icons.search, color: Colors.grey),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          _buildSearchList()[index],
                                          softWrap: true,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                    child: Text(
                      "Top Searches :-",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.only(top: 5.0),
                      shrinkWrap: true,
                      itemCount: topSearches.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.av_timer),
                          title: Text(topSearches[index]),
                        );
                      })
                ],
              ),
            ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  List<String> _buildSearchList() {
    List<String> _searchList = List();
    for (int i = 0; i < productNames.length; i++) {
      String name = productNames.elementAt(i);
      if (name.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchList.add(name);
      }
    }

    return _searchList;
  }
}
