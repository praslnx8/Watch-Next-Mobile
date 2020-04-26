import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/core/auth_util.dart';
import 'package:movie_suggestion/queries/movie_query.dart';
import 'package:movie_suggestion/queries/user_query.dart';
import 'package:movie_suggestion/screens/home_screen.dart';

class TrendingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendingScreenState();
  }
}

class _TrendingScreenState extends State<TrendingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Query(
                options: QueryOptions(
                    documentNode: gql(MovieQuery.trendingMoviesQuery)),
                builder: (QueryResult result,
                    {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.loading) {
                    return Center(child: Text("Loading"));
                  }
                  if (result.hasException) {
                    return Center(child: Text(result.exception.toString()));
                  }

                  final resultData = result.data['getTrendingMovies'];
                  return Text("Loaded");
                })));
  }
}
