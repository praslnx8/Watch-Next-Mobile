import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUtil {
  static final _firebaseAuth = FirebaseAuth.instance;

  static Future<String> getToken() async {
    final firebaseUser = await _firebaseAuth.currentUser();

    return await firebaseUser?.getIdToken();
  }

  static Future<String> authenticateUser() async {
    try {
      final googleSignInAccount = await GoogleSignIn().signIn();
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final user = await FirebaseAuth.instance.signInWithCredential(credential);

      return user?.getIdToken();
    } catch (ignore) {}

    return null;
  }
}
