import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 20, left: 10,right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 20),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/shop_image.jpeg",
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "About us.",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_downward,
                    size: 40,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "What we do",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "Anil Store is an online grocery(kirana) app. With few clicks on your phone, you will receive your preferred grocery at your door. Fine choice just at your fingertips. There is no need of unnecessary rush and time-consuming trips to the supermarket when we are available for you. Easy payment and refund. With Anil store, we do some quality checks and recheck your order before delivery, as to reduce your effort. We give you assurance of quality products and hassle-free replacement of damaged product. Get monthly kirana for your home and a preferred discount every month."),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Shop Address:-",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Anil Store \nMohaddinagar,Mirjanhat Road \nBhagalpur-812005 \nBihar, India \n +91-6203104701"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Developer Details:-",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/developer_image.jpeg",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Abhishek Kumar Sah"),
              Text("App Developer (Android & Flutter)"),
              Text("Ph.No:- +918809765191"),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Github:- ",
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              _launchUrl(
                                  "https://www.github.com/theabhishekavi");
                            },
                            child: Text(
                              "https://www.github.com/theabhishekavi",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).primaryColor),
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "LindedIn:- ",
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _launchUrl(
                            "https://www.linkedin.com/in/abhishek-kumar-sah-737948144");
                      },
                      child: Text(
                        "https://www.linkedin.com/in/abhishek-kumar-sah-737948144",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
