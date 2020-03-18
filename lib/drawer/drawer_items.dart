import 'package:flutter/material.dart';
import 'package:shop/Screens/favourite_screen.dart';
import 'package:shop/Screens/profile_screen.dart';

class DrawerItems extends StatefulWidget {
  @override
  _DrawerItemsState createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  static const TextStyle optionStyleDrawer = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Alok Kumar'),
            accountEmail: Text('alok4045@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'My Account',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.account_circle),
            onTap: () { 
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
              }
          ),
          ListTile(
            title: Text(
              'My Notifications',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.notifications_active),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text(
              'My Orders',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.add_shopping_cart),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
              title: Text(
                'Favourites',
                style: optionStyleDrawer,
              ),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(FavouritePage.routeName);
              }),
          ListTile(
            title: Text(
              'Rate App',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.rate_review),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text(
              'Need Help',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.help),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text(
              'Share',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.share),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text(
              'Legals',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.comment),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text(
              'Logout',
              style: optionStyleDrawer,
            ),
            leading: Icon(Icons.input),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
