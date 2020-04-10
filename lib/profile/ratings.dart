import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/ratings_model.dart';
import 'package:shop/utils/strings.dart';

class MyRatings extends StatefulWidget {
  @override
  _MyRatingsState createState() => _MyRatingsState();
}

class _MyRatingsState extends State<MyRatings> {
  List<RatingModel> ratingList = [];
  @override
  void initState() {
    super.initState();
    getRatingsFromDatabase().then((_) {
      setState(() {});
    });
  }

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  SharedPreferences sharedPreferences;
  String userId;

  Future<void> getRatingsFromDatabase() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString(StringKeys.userId);
    await databaseReference
        .child('users')
        .child(userId)
        .child('ratings')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      if (map != null) {
        map.forEach((key, keyValue) {
          RatingModel ratingModel =
              RatingModel(productName: key, rating: keyValue['star_count']);
          ratingList.add(ratingModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ratings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Rated Products',style: TextStyle(fontSize: 20),),
            ),
            ListView.builder(
                itemCount: ratingList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                flex: 1,
                                child: Text(ratingList[index].productName ,style: TextStyle(fontSize: 17),)),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  (ratingList[index].rating >= 1)
                                      ? Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : Icon(Icons.star_border),
                                  (ratingList[index].rating >= 2)
                                      ? Icon(Icons.star,
                                          color: Theme.of(context).primaryColor,)
                                      : Icon(Icons.star_border),
                                  (ratingList[index].rating >= 3)
                                      ? Icon(Icons.star,
                                          color: Theme.of(context).primaryColor,)
                                      : Icon(Icons.star_border),
                                  (ratingList[index].rating >= 4)
                                      ? Icon(Icons.star,
                                          color: Theme.of(context).primaryColor,)
                                      : Icon(Icons.star_border),
                                  (ratingList[index].rating >= 5)
                                      ? Icon(Icons.star,
                                          color: Theme.of(context).primaryColor,)
                                      : Icon(Icons.star_border),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
