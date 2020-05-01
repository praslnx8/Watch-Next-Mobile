import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/queries/movie_query.dart';

class MovieDetailScreen extends StatefulWidget {
  @override
  MovieDetailState createState() {
    return MovieDetailState();
  }
}

class MovieDetailState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Query(
          options: QueryOptions(
            documentNode: gql(MovieQuery.trendingMoviesQuery)
          ),
        ),
      ),
    );
  }
}
