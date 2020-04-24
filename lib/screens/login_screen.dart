import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String doLogin = r'''
  mutation login($idToken: String!) {
    login(idToken: $idToken) {
      name
    }
  }
  ''';

  @override
  void initState() {
    super.initState();
  }

  void _navigateToHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
    );
  }

  Widget _signInButton(bool isLoading) {
    return Mutation(
        options: MutationOptions(
            documentNode: gql(doLogin),
            onCompleted: (dynamic resultData) {
              print(resultData);
              _navigateToHome();
            }),
        builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          if (result.loading) {
            return CircularProgressIndicator();
          }
          if (result.hasException) {
            print(result.exception);
          }
          return OutlineButton(
            splashColor: Colors.grey,
            onPressed: () async {
              final GoogleSignInAccount googleSignInAccount =
                  await GoogleSignIn().signIn();
              final GoogleSignInAuthentication googleSignInAuthentication =
                  await googleSignInAccount.authentication;

              final AuthCredential credential =
                  GoogleAuthProvider.getCredential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken,
              );

              final FirebaseUser user =
                  await FirebaseAuth.instance.signInWithCredential(credential);

              runMutation({'idToken': await user.getIdToken()});
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 35.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(true),
            ],
          ),
        ),
      ),
    );
  }
}
