import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google Sign-In cancelled by user');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error in signInWithGoogle: $e');
      rethrow;
    }
  }

  // Future<User?> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     if (result.status == LoginStatus.success) {
  //       final AccessToken accessToken = result.accessToken!;
  //       final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token!); // Corrected line
  //       final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //       return userCredential.user;
  //     }
  //     return null;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }
  // Future<void> signOut() async {
  //   await FacebookAuth.instance.logOut();
  //   await _auth.signOut();
  // }
}
