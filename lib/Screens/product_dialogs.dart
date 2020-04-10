import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProductDialog {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  Future<void> askQuestionDialog(
      BuildContext context, String userId, String productName) async {
    TextEditingController _questionController = TextEditingController(text: "");
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Center(
              child: Text(
                'Ask your Question',
                // style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Product Name : $productName',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  ),
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: _questionController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      hintText: "Write your question in maximum 50 words!",
                      contentPadding: EdgeInsets.all(0.0),
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    maxLength: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                      'Note: On successful validation, answer will be updated in your profile'),
                ),
                RaisedButton(
                  onPressed: ()async {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    if (_questionController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "First write your Question!");
                    } else {
                      await updateQuestionToDatabase(
                              _questionController.text, userId, productName)
                          .then((_) {
                            Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: 'Question submitted succesfully');
                      });
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          );
        });
  }

  Future<void> updateQuestionToDatabase(
      String question, String userId, String productName) async {
    String time = DateFormat("dd-MM-yyyy").format(DateTime.now());
    await databaseReference
        .child("users")
        .child(userId)
        .child('questions')
        .push()
        .set({'question': question, 'productName': productName,'time':time,'answer':""});
  }

  Future<void> reviewDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Center(
                child: Text(
              'Add your Review',
              style: TextStyle(fontWeight: FontWeight.w400),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      hintText: "Write Your review in maximum 100 word!",
                      contentPadding: EdgeInsets.all(0.0),
                      border: InputBorder.none,
                    ),
                    maxLines: 10,
                    textInputAction: TextInputAction.done,
                    maxLength: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
