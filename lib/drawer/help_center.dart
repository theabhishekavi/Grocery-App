import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Help Center",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Please get in touch and we'),
                            SizedBox(
                              height: 5,
                            ),
                            Text("will be happy to help you")
                          ],
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          child:
                              Image.asset('assets/empty_images/help_desk.jpeg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Contact us on:-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Ph.No:- +91 6203104701"),
                      Text("              +91 7631532429"),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Address:-",
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Anil Store \nMohaddinagar,Mirjanhat Road \nBhagalpur-812005 \nBihar, India"),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("You can also write us on :- "),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "help.anilstore@outlook.com ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "anilstore812005@gmail.com",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
