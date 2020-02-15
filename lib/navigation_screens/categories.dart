import 'package:flutter/material.dart';
import 'package:shop/Screens/product_screen.dart';
import 'package:shop/models/category_type.dart';

class CategoriesPage extends StatelessWidget {
  final List<CategoryModel> categoriesList = [
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

  @override
  Widget build(BuildContext context) {
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
                          Image.network(categoriesList[index].categoryImage1,),
                          Text(
                            categoriesList[index].categoryName1,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2,),
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
                          Image.network(categoriesList[index].categoryImage1),
                          Text(
                            categoriesList[index].categoryName2,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2,),
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
                          Image.network(categoriesList[index].categoryImage1),
                          Text(
                            categoriesList[index].categoryName3,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2,),
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
                          Image.network(categoriesList[index].categoryImage1),
                          Text(
                            categoriesList[index].categoryName4,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2,),
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
