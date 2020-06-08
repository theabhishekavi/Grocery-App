import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import '../Screens/product_screen.dart';
import '../models/category_type.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextStyle myStyle = TextStyle(
    fontSize: 15,
  );

  final TextStyle myStyleSmall = TextStyle(
    fontSize: 12,
    color: Colors.grey[600],
  );

  List<CategoryModel> categoriesList = [];

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  bool loadDataFromFirebase = false;
  List<String> slideShowImages = [];

  @override
  void initState() {
    super.initState();
    getFirebaseData().then((_) {
      if(mounted)
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
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,),
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: (loadDataFromFirebase == false)
            ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(child: loadingIndicator),
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: 170,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      images: imageFromNetwork(slideShowImages),
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.pink[300],
                      indicatorBgPadding: 2.0,
                      autoplay: true,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 3000),
                    ),
                  ),
                  categories(context),
                ],
              ),
      ),
    );
  }

  void passData(BuildContext ctx, String catType, String catName) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ProductScreen(
            categoryType: catType,
            categoryName: catName,
          );
        },
      ),
    );
  }

  Future<void> getFirebaseData() async {
    String catTypeName, catTypeImage;
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
          }

          CategoryModel categoryModel = CategoryModel(
            categoryType: catTypeName,
            categoryTypeImage: catTypeImage,
            subCategoryList: subCategoryList,

          );
          categoriesList.add(categoryModel);
        
      });
    });

    await databaseReference
        .child('slide_show_images')
        .once()
        .then((DataSnapshot snapshot) {
      List<dynamic> list = snapshot.value;
      for (int i = 1; i < list.length; i++) {
        slideShowImages.add(list[i]);
      }
    });
  }

  static List<dynamic> imageFromNetwork(List<String> images) {
    List<dynamic> res = [];
    for (int i = 0; i < images.length; i++) {
      res.add(Image.network(
        images[i],
        fit: BoxFit.cover,
      ));
    }
    return res;
  }

  Widget categories(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: categoriesList.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10, 8.0, 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //offer images
              // (index != 0 && index % 2 == 0)
              //     ? Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           color: Colors.grey,
              //           height: 100,
              //           width: double.infinity,
              //           //offer images
              //           child: Container()
              //         ),
              //       )
              //     : Padding(
              //         padding: const EdgeInsets.all(0.0),
              //       ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  categoriesList[index].categoryType,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              GridView.builder(
                itemCount: categoriesList[index].subCategoryList.length,
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(top: 10),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,subIndex){
                  return Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => passData(
                          context,
                          categoriesList[index].categoryType,
                          categoriesList[index].subCategoryList[subIndex].categoryName),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 4,
                            child: Image.network(
                              categoriesList[index].subCategoryList[subIndex].categoryImage,
                            ),
                          ),
                          Text(
                            categoriesList[index].subCategoryList[subIndex].categoryName,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                  
                },
                // children: <Widget>[
                //   Card(
                //     elevation: 5.0,
                //     child: InkWell(
                //       onTap: () => passData(
                //           context,
                //           categoriesList[index].categoryType,
                //           categoriesList[index].categoryName1),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: <Widget>[
                //           Container(
                //             width: MediaQuery.of(context).size.width / 3,
                //             height: MediaQuery.of(context).size.width / 4,
                //             child: Image.network(
                //               categoriesList[index].categoryImage1,
                //             ),
                //           ),
                //           Text(
                //             categoriesList[index].categoryName1,
                //             style: TextStyle(fontSize: 14),
                //             textAlign: TextAlign.center,
                //           ),
                //           SizedBox(
                //             height: 2,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   Card(
                //     elevation: 5.0,
                //     child: InkWell(
                //       onTap: () => passData(
                //           context,
                //           categoriesList[index].categoryType,
                //           categoriesList[index].categoryName2),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: <Widget>[
                //           Container(
                //               width: MediaQuery.of(context).size.width / 3,
                //               height: MediaQuery.of(context).size.width / 4,
                //               child: Image.network(
                //                 categoriesList[index].categoryImage2,
                //                 fit: BoxFit.cover,
                //               )),
                //           Text(
                //             categoriesList[index].categoryName2,
                //             style: TextStyle(fontSize: 14),
                //             textAlign: TextAlign.center,
                //           ),
                //           SizedBox(
                //             height: 2,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   Card(
                //     elevation: 5.0,
                //     child: InkWell(
                //       onTap: () => passData(
                //           context,
                //           categoriesList[index].categoryType,
                //           categoriesList[index].categoryName3),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: <Widget>[
                //           Container(
                //               width: MediaQuery.of(context).size.width / 3,
                //               height: MediaQuery.of(context).size.width / 4,
                //               child: Image.network(
                //                   categoriesList[index].categoryImage3)),
                //           Text(
                //             categoriesList[index].categoryName3,
                //             style: TextStyle(fontSize: 14),
                //             textAlign: TextAlign.center,
                //           ),
                //           SizedBox(
                //             height: 2,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   Card(
                //     elevation: 5.0,
                //     child: InkWell(
                //       onTap: () => passData(
                //           context,
                //           categoriesList[index].categoryType,
                //           categoriesList[index].categoryName4),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: <Widget>[
                //           Container(
                //             width: MediaQuery.of(context).size.width / 3,
                //             height: MediaQuery.of(context).size.width / 4,
                //             child: Image.network(
                //               categoriesList[index].categoryImage4,
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //           Text(
                //             categoriesList[index].categoryName4,
                //             style: TextStyle(fontSize: 14),
                //             textAlign: TextAlign.center,
                //           ),
                //           SizedBox(
                //             height: 2,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
