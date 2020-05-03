import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/models/movie_info.dart';
import 'package:movie_suggestion/models/user_info.dart';
import 'package:movie_suggestion/queries/movie_query.dart';
import 'package:movie_suggestion/widgets/movie_card.dart';

class TrendingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendingScreenState();
  }
}

class _TrendingScreenState extends State<TrendingScreen>
    with AutomaticKeepAliveClientMixin<TrendingScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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

                  final resultData = MovieInfo.getMovieInfoList(
                      result.data['me']['getTrendingMovies']);

                  final userInfo = UserInfo.fromJson(result.data['me']);

                  return ListView(
                    children: resultData
                        .map((movieInfo) => MovieCard(userInfo, movieInfo))
                        .toList(),
                  );
                })));
  }

  @override
  bool get wantKeepAlive => true;
}
