import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/core/auth_util.dart';
import 'package:movie_suggestion/queries/login_query.dart';
import 'package:movie_suggestion/screens/home_screen.dart';

class TrendingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendingScreenState();
  }
}

class _TrendingScreenState extends State<TrendingScreen> {
  bool _isChecking = true;

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
    );
  }

  Widget _signInButton() {
    return Mutation(
        options: MutationOptions(
            documentNode: gql(UserQuery.loginQuery),
            onCompleted: (dynamic resultData) {
              if (resultData['login'] != null) {
                _navigateToHome();
              }
            }),
        builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          if (result.loading) {
            return CircularProgressIndicator();
          } else if (_isChecking) {
            _checkAndLogin(runMutation);
            return CircularProgressIndicator();
          } else {
            return OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {
                authenticate(runMutation);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
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
          }
        });
  }

  Future _checkAndLogin(runMutation) async {
    String idToken = await AuthUtil.getToken();

    if (idToken != null) {
      _isChecking = false;
      runMutation({'idToken': idToken});
    } else {
      setState(() {
        _isChecking = false;
      });
    }
  }

  Future authenticate(RunMutation runMutation) async {
    final authenticatedToken = AuthUtil.authenticateUser();

    if (authenticatedToken != null) {
      runMutation({'idToken': await authenticatedToken});
    } else {
      //TODO show error message.
    }
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
            _signInButton(),
          ],
        ),
      ),
    ));
  }
}
