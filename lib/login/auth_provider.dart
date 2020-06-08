import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      assert(authResult != null);
      FirebaseUser firebaseUser = authResult.user;
      if (firebaseUser.getIdToken() != null)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<AuthResultWithEmailAndPhoto> signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes:<String>['email','https://www.googleapis.com/auth/userinfo.profile'] ); 
      GoogleSignInAccount account = await _googleSignIn.signIn();
      if (account == null) return AuthResultWithEmailAndPhoto(authResult: false,emailId: "",photoUrl: "");
      AuthResult authResult = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken),
      );
      if (authResult.user == null) return AuthResultWithEmailAndPhoto(authResult: false,emailId: "",photoUrl: "");
       print('${account.displayName} and ${account.email} ${account.photoUrl}');
      return AuthResultWithEmailAndPhoto(authResult: true,emailId: account.email,photoUrl: account.photoUrl);
    } catch (e) {
      return AuthResultWithEmailAndPhoto(authResult: false,emailId: "",photoUrl: "");
    }
  }

  Future<void> signOutWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<bool> loginWithFacebook() async {
    try {
      FacebookLogin facebookLogin = new FacebookLogin();
      FacebookLoginResult result =
          await facebookLogin.logIn(['email', 'public_profile']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        AuthResult authResult = await _auth.signInWithCredential(
          FacebookAuthProvider.getCredential(
            accessToken: (result.accessToken.token),
          ),
        );
        if (authResult.user == null) return false;
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(authResult != null);
      FirebaseUser user = authResult.user;
      if (user.getIdToken() != null)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try{
    await _auth.sendPasswordResetEmail(email: email);
    return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }
}
class AuthResultWithEmailAndPhoto{
  final String emailId, photoUrl;
  final bool authResult;

  AuthResultWithEmailAndPhoto({this.authResult,this.emailId,this.photoUrl});

}
