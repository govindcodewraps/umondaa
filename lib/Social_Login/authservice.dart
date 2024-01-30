import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger Google Sign In
      final GoogleSignInAccount gUser = await GoogleSignIn().signIn();

      // Get Google Sign In Authentication
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create Firebase Auth Credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with Firebase Auth Credential
      UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Print the user email
      print("User email: ${authResult.user.email}");

      // Return the UserCredential
      return authResult;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }
}
