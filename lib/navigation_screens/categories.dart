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
      setState(() {
        loadDataFromFirebase = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = Container(
      width: 120,
      height: 120,
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
        ? loadingIndicator
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
                                  opacity: 0.6,
                                  child: Image.network(
                                    'https://d27zlipt1pllog.cloudfront.net/pub/media/catalog/product/j/o/joh0156.jpg',
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
                                        Text(
                                          '${categoriesList[index].categoryName1} \n ${categoriesList[index].categoryName2} \n ${categoriesList[index].categoryName3} \n ${categoriesList[index].categoryName4}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        ),
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
                  ],
                ),
              );
            },
          );
  }

  Future<void> getFirebaseData() async {
    String catTypeName, catTypeImage;
    String category1Name, category2Name, category3Name, category4Name;
    await databaseReference
        .child('categories')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((catTypeKey, catTypevalue) {
        catTypeName = catTypeKey;
        catTypeImage = catTypevalue['cat_image'];

        if (catTypeName == 'Baby Care') {
          //subcategories(1 to 4)
          for (int i = 1; i <= 4; i++) {
            Map<dynamic, dynamic> val = catTypevalue['$i'];
            if (i == 1) {
              category1Name = val['category_name'];
            } else if (i == 2) {
              category2Name = val['category_name'];
            } else if (i == 3) {
              category3Name = val['category_name'];
            } else if (i == 4) {
              category4Name = val['category_name'];
            }
          }
          CategoryModel categoryModel = CategoryModel(
            categoryType: catTypeName,
            categoryTypeImage: catTypeImage,
            categoryName1: category1Name,
            categoryName2: category2Name,
            categoryName3: category3Name,
            categoryName4: category4Name,
          );
          categoriesList.add(categoryModel);
        }
      });
    });
  }
}
