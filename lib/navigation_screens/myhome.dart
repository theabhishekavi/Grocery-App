import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import '../Screens/product_screen.dart';
import '../models/category_type.dart';

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
            categories(context),
          ],
        ),
      ),
    );
  }

  final List<CategoryModel> categoriesList = [
    CategoryModel(
      categoryType: 'BreakFast Essentials',
      categoryName1: 'Bread Jam',
      categoryImage1:
          'https://www.zabsupply.co.za/wp-content/uploads/2019/05/ZAB1331.png',
      categoryName2: 'Dry Fruits',
      categoryImage2:
          'https://d27zlipt1pllog.cloudfront.net/pub/media/catalog/product/j/o/joh0156.jpg',
      categoryName3: 'Horlicks Complan Bournvita',
      categoryImage3:
          'https://cubereach.com/demo/baniyachacha/dev/wp-content/uploads/2019/05/IHealthDrinks500gBNVT2857XX290216_9_B.jpg',
      categoryName4: 'Corn Flakes Oats Dalia',
      categoryImage4:
          "https://5.imimg.com/data5/XG/QF/MY-3913207/baby-diaper-500x500.jpg",
    ),
    CategoryModel(
      categoryType: 'Quick Prepare',
      categoryName1: 'Maggie Monchow Soup',
      categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName2: 'Cookies & Bakery Products',
      categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName3: 'Tea Green Tea Cornflakes Chocos',
      categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName4: 'Chow Pasta ketchup',
      categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    ),
    CategoryModel(
      categoryType: 'BreakFast Essentials',
      categoryName1: 'Bread Jam',
      categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName2: 'Dry Fruits',
      categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName3: 'Horlicks Complan Bournvita',
      categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName4: 'Corn Flakes Oats Dalia',
      categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    ),
    CategoryModel(
      categoryType: 'BreakFast Essentials',
      categoryName1: 'Bread Jam',
      categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName2: 'Dry Fruits',
      categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName3: 'Horlicks Complan Bournvita',
      categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName4: 'Corn Flakes Oats Dalia',
      categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    ),
    CategoryModel(
      categoryType: 'BreakFast Essentials',
      categoryName1: 'Bread Jam',
      categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName2: 'Dry Fruits',
      categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName3: 'Horlicks Complan Bournvita',
      categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName4: 'Corn Flakes Oats Dalia',
      categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    ),
    CategoryModel(
      categoryType: 'BreakFast Essentials',
      categoryName1: 'Bread Jam',
      categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName2: 'Dry Fruits',
      categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName3: 'Horlicks Complan Bournvita',
      categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName4: 'Corn Flakes Oats Dalia',
      categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    ),
    CategoryModel(
      categoryType: 'BreakFast Essentials',
      categoryName1: 'Bread Jam',
      categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName2: 'Dry Fruits',
      categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName3: 'Horlicks Complan Bournvita',
      categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName4: 'Corn Flakes Oats Dalia',
      categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    ),
    CategoryModel(
      categoryType: 'BreakFast Essentials',
      categoryName1: 'Bread Jam',
      categoryImage1: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName2: 'Dry Fruits',
      categoryImage2: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName3: 'Horlicks Complan Bournvita',
      categoryImage3: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
      categoryName4: 'Corn Flakes Oats Dalia',
      categoryImage4: 'https://i.ytimg.com/vi/OuYoVDDr7_8/hqdefault.jpg',
    ),
  ];

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
              (index != 0 && index % 2 == 0)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: 100,
                        width: double.infinity,
                        child: Image.network(
                          categoriesList[index].categoryImage1,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(0.0),
                    ),
              Text(
                categoriesList[index].categoryType,
                style: TextStyle(fontSize: 17),
              ),
              GridView(
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(top: 10),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => passData(
                          context,
                          categoriesList[index].categoryType,
                          categoriesList[index].categoryName1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.width/4,
                            child: Image.network(
                              categoriesList[index].categoryImage1,
                            ),
                          ),
                          Text(
                            categoriesList[index].categoryName1,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => passData(
                          context,
                          categoriesList[index].categoryType,
                          categoriesList[index].categoryName2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.width/4,
                              child: Image.network(
                            categoriesList[index].categoryImage2,
                            fit: BoxFit.cover,
                          )),
                          Text(
                            categoriesList[index].categoryName2,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => passData(
                          context,
                          categoriesList[index].categoryType,
                          categoriesList[index].categoryName3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 4,
                              child: Image.network(
                                  categoriesList[index].categoryImage3)),
                          Text(
                            categoriesList[index].categoryName3,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => passData(
                          context,
                          categoriesList[index].categoryType,
                          categoriesList[index].categoryName4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.width/4,
                            child: Image.network(
                              categoriesList[index].categoryImage4,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            categoriesList[index].categoryName4,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
