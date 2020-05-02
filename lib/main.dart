import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/core/graphql_conf.dart';
import 'package:movie_suggestion/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfiguration.client,
      child: CacheProvider(
          child: MaterialApp(
        title: 'Watch Next',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: LoginScreen(),
      )),
    );
  }
}
