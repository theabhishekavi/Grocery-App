import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/question_answer_model.dart';
import 'package:shop/utils/strings.dart';

class QuestionAnswer extends StatefulWidget {
  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  SharedPreferences sharedPreferences;
  String userId;
  List<QuestionAnswerModel> questionAnswerList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getDatabaseQuestions().then((_) {
      setState(() {
        loading = false;
        questionAnswerList.sort((one, two) {
          List<String> splitOne = one.time.split('-');
          List<String> splitTwo = two.time.split('-');
          if (splitTwo[2].compareTo(splitOne[2]) != 0)
            return splitTwo[2].compareTo(splitOne[2]);
          else if (splitTwo[1].compareTo(splitOne[1]) != 0)
            return splitTwo[1].compareTo(splitOne[1]);
          else if (splitTwo[0].compareTo(splitOne[0]) != 0)
            return splitTwo[0].compareTo(splitOne[0]);
        });
      });
    });
  }

  Future<void> getDatabaseQuestions() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString(StringKeys.userId);
    await databaseReference
        .child("users")
        .child(userId)
        .child('questions')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      if (map != null) {
        map.forEach((key, keyValue) {
          if (keyValue != null) {
            QuestionAnswerModel questionAnswerModel = QuestionAnswerModel(
                question: keyValue['question'],
                productName: keyValue['productName'],
                time: keyValue['time'],
                answer: keyValue['answer']);
            questionAnswerList.add(questionAnswerModel);
          }
        });
      }
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Question & Answers'),
      ),
      body: (loading)
          ? loadingIndicator
          : SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.all(8.0),
                                child: Text(
                                  'Posted On : ${questionAnswerList[index].time}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0),
                                        child: Text(
                                          'Product Name: ${questionAnswerList[index].productName}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0),
                                        child: Text(
                                          'Q${index + 1}. ${questionAnswerList[index].question}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontStyle: FontStyle.italic,
                                              color:
                                                  Theme.of(context).accentColor),
                                        ),
                                      ),
                                      (questionAnswerList[index].answer == "")
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 8.0,
                                                  bottom: 8.0),
                                              child: Text(
                                                'Answer awaiting',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.green),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 8.0,
                                                  bottom: 8.0),
                                              child: Text(
                                                'Ans:- ${questionAnswerList[index].answer}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.green),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: questionAnswerList.length,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
