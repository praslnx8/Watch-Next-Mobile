import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_suggestion/core/bloc.dart';
import 'package:movie_suggestion/core/view_state.dart';

class LoginBloc extends Bloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final StreamController _loginController =
      StreamController<ViewState<int, int, int>>();

  StreamSink<ViewState<int, int, int>> get _loginResultSink =>
      _loginController.sink;

  Stream<ViewState<int, int, int>> get loginResultStream =>
      _loginController.stream;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final FirebaseUser user = await _auth.signInWithCredential(credential);
      //TODO send idToken to api and login.

      _loginResultSink.add(ViewState.setData(1));
    } catch (err) {
      print(err);
      _loginResultSink.add(ViewState.setData(1));
    }
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();

    print("User Sign Out");
  }

  @override
  void dispose() {
    _loginController.close();
  }
}
