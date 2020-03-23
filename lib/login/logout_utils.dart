import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/login/login_screen.dart';
import '../utils/strings.dart';

class LogoutUtils {


  void logout(BuildContext context, SharedPreferences sharedPreferences) {
    sharedPreferences.remove(StringKeys.isLoggedIn);
    sharedPreferences.remove(StringKeys.providerName);
    sharedPreferences.remove(StringKeys.userId);
    FirebaseAuth.instance.signOut();
    // AuthProvider().signOutWithGoogle();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
}
