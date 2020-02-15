import 'package:flutter/material.dart';
import 'package:shop/drawer/drawer_items.dart';
import './navigation_screens/cart.dart';
import './navigation_screens/categories.dart';
import './navigation_screens/myhome.dart';
import './navigation_screens/offers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyHomePage _myHomePage;
  CategoriesPage _categoriesPage;
  OffersPage _offersPage;
  CartPage _cartPage;

  List<Widget> pages;
  Widget currentPage;

  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
  

  @override
  void initState() {
    _myHomePage = MyHomePage();
    _categoriesPage = CategoriesPage();
    _offersPage = OffersPage();
    _cartPage = CartPage();

    pages = [_myHomePage, _categoriesPage, _offersPage, _cartPage];
    currentPage = _myHomePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'HOME',
              style: optionStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text(
              'CATEGORIES',
              style: optionStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            title: Text(
              'Offers',
              style: optionStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text(
              'CART',
              style: optionStyle,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Theme.of(context).accentColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
        title: Text('Anil Store'),
      ),
      drawer: DrawerItems()
    );
  }
}
