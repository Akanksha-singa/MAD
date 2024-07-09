import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

// Sign in with Facebook
//   Future<User?> signInWithFacebook() async {
//     try {
//       final _instance = FacebookAuth.instance;
//       final result = await _instance.login(permissions: ['email']);
//       if (result.status == LoginStatus.success) {
//         final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
//         final UserCredential userCredential = await _auth.signInWithCredential(credential);
//
//         // Optionally update the user's email
//         await _instance.getUserData().then((userData) async {
//           await userCredential.user!.updateEmail(userData['email']);
//         });
//
//         return userCredential.user;
//       } else if (result.status == LoginStatus.cancelled) {
//         throw Exception('Login cancelled');
//       } else {
//         throw Exception('Error logging in with Facebook');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }


  }

  // Sign in with Apple
  // Future<User?> signInWithApple() async {
  //   try {
  //     final AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //     final AuthCredential credential = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       accessToken: appleCredential.authorizationCode,
  //     );
  //     final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

