import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop/Screens/product_screen.dart';
import 'package:shop/models/category_type.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  final List<CategoryModel> categoriesList = [
    // CategoryModel(
    //   categoryType: 'BreakFast Essentials',
    //   categoryName1: 'Bread Jam',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Dry Fruits',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Horlicks Complan Bournvita',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Corn Flakes Oats Dalia',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
    // CategoryModel(
    //   categoryType: 'Quick Prepare',
    //   categoryName1: 'Maggie Monchow Soup',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Cookies & Bakery Products',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Tea Green Tea Cornflakes Chocos',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Chow Pasta ketchup',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
    // CategoryModel(
    //   categoryType: 'BreakFast Essentials',
    //   categoryName1: 'Bread Jam',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Dry Fruits',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Horlicks Complan Bournvita',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Corn Flakes Oats Dalia',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
    // CategoryModel(
    //   categoryType: 'BreakFast Essentials',
    //   categoryName1: 'Bread Jam',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Dry Fruits',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Horlicks Complan Bournvita',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Corn Flakes Oats Dalia',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
    // CategoryModel(
    //   categoryType: 'BreakFast Essentials',
    //   categoryName1: 'Bread Jam',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Dry Fruits',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Horlicks Complan Bournvita',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Corn Flakes Oats Dalia',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
    // CategoryModel(
    //   categoryType: 'BreakFast Essentials',
    //   categoryName1: 'Bread Jam',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Dry Fruits',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Horlicks Complan Bournvita',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Corn Flakes Oats Dalia',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
    // CategoryModel(
    //   categoryType: 'BreakFast Essentials',
    //   categoryName1: 'Bread Jam',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Dry Fruits',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Horlicks Complan Bournvita',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Corn Flakes Oats Dalia',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
    // CategoryModel(
    //   categoryType: 'BreakFast Essentials',
    //   categoryName1: 'Bread Jam',
    //   categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName2: 'Dry Fruits',
    //   categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName3: 'Horlicks Complan Bournvita',
    //   categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    //   categoryName4: 'Corn Flakes Oats Dalia',
    //   categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    // ),
  ];

  bool loadDataFromFirebase = false;

  void passData(BuildContext ctx, String catType) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ProductScreen(
            categoryType: catType,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getFirebaseData().then((_) {
      if (mounted)
        setState(() {
          loadDataFromFirebase = true;
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
        color: Colors.white,
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

    return (loadDataFromFirebase == false)
        ? Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(child: loadingIndicator),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: categoriesList.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10, 8.0, 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () => passData(
                        context,
                        categoriesList[index].categoryType,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          child: Center(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  child: Opacity(
                                    opacity: 0.4,
                                    child: Image.network(
                                      categoriesList[index].categoryTypeImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        categoriesList[index].categoryType,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          (categoriesList[index]
                                                      .subCategoryList
                                                      .length >=
                                                  1)
                                              ? Text(
                                                  '${categoriesList[index].subCategoryList[0].categoryName}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : Text(""),
                                          (categoriesList[index]
                                                      .subCategoryList
                                                      .length >=
                                                  2)
                                              ? Text(
                                                  '${categoriesList[index].subCategoryList[1].categoryName}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : Text(""),
                                          (categoriesList[index]
                                                      .subCategoryList
                                                      .length >=
                                                  3)
                                              ? Text(
                                                  '${categoriesList[index].subCategoryList[2].categoryName}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : Text(""),
                                          (categoriesList[index]
                                                      .subCategoryList
                                                      .length >=
                                                  4)
                                              ? Text(
                                                  '${categoriesList[index].subCategoryList[3].categoryName}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : Text(""),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  Future<void> getFirebaseData() async {
    String catTypeName, catTypeImage;
    // String category1Name, category2Name, category3Name, category4Name;
    await databaseReference
        .child('categories')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((catTypeKey, catTypevalue) {
        catTypeName = catTypeKey;
        catTypeImage = catTypevalue['cat_image'];

        //subcategories(1 to 4)
        List<SubCategoryModel> subCategoryList = [];
        for (int i = 1; i < catTypevalue.length; i++) {
          Map<dynamic, dynamic> val = catTypevalue['$i'];

          SubCategoryModel subCategoryModel = SubCategoryModel(
              categoryName: val['category_name'],
              categoryImage: val['category_image']);
          subCategoryList.add(subCategoryModel);
          // if (i == 1) {
          //   category1Name = val['category_name'];
          // } else if (i == 2) {
          //   category2Name = val['category_name'];
          // } else if (i == 3) {
          //   category3Name = val['category_name'];
          // } else if (i == 4) {
          //   category4Name = val['category_name'];
          // }
        }
        CategoryModel categoryModel = CategoryModel(
          categoryType: catTypeName,
          categoryTypeImage: catTypeImage,
          subCategoryList: subCategoryList,
        );
        categoriesList.add(categoryModel);
      });
    });
  }
}
