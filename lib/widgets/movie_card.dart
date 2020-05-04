import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/models/movie_info.dart';
import 'package:movie_suggestion/models/user_info.dart';
import 'package:movie_suggestion/queries/movie_query.dart';
import 'package:movie_suggestion/widgets/poster.dart';
import 'package:movie_suggestion/widgets/rating_information.dart';

import 'arc_banner_image.dart';

class MovieCard extends StatefulWidget {
  final UserInfo userInfo;
  final MovieInfo movieInfo;

  MovieCard([this.userInfo, this.movieInfo]);

  @override
  _MovieCardState createState() => _MovieCardState(userInfo, movieInfo);
}

class _MovieCardState extends State<MovieCard> {
  final UserInfo userInfo;
  final MovieInfo movieInfo;

  _MovieCardState([this.userInfo, this.movieInfo]);

  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Text(
          movieInfo.title,
          style: textTheme.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(height: 8.0),
        RatingInformation(userInfo, movieInfo),
        SizedBox(height: 12.0),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: _buildCategoryChips(textTheme))),
      ],
    );

    return Card(
        margin: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 120.0),
              child: ArcBannerImage(movieInfo.backDrops[0]),
            ),
            Positioned(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[_addToWatchLaterIcon()],
            )),
            Positioned(
              bottom: 0.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Poster(
                    movieInfo.posters[0],
                    height: 100.0,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(child: movieInformation),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _addToWatchLaterIcon() {
    return Mutation(
      options: MutationOptions(
          documentNode: gql(MovieQuery.addMovieToWatchLater),
          update: _updateCache),
      builder: (RunMutation runMutation, QueryResult queryResult) {
        return Container(
          decoration: BoxDecoration(
              gradient:
                  RadialGradient(colors: [Colors.black45, Colors.transparent])),
          child: IconButton(
            color: Colors.white,
            onPressed: () {
              movieInfo.addedAsWatchLater =
                  movieInfo.addedAsWatchLater ? false : true;
              runMutation({
                'movieId': movieInfo.id,
                'add': movieInfo.addedAsWatchLater
              });
            },
            icon: movieInfo.addedAsWatchLater
                ? Icon(Icons.bookmark)
                : Icon(Icons.bookmark_border),
          ),
        );
      },
    );
  }

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return movieInfo.genres.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: Chip(
          label: Text(category),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  _updateCache(Cache cache, QueryResult result) {
    final userData = cache.read(typenameDataIdFromObject(userInfo.toJson()));
    final List<dynamic> watchLaterMovies = userData['getWatchLaterMovies'];
    if (watchLaterMovies != null) {
      if (movieInfo.addedAsWatchLater) {

      } else {

      }
      cache.write(typenameDataIdFromObject(userInfo.toJson()), userData);
    }
    cache.write(
        typenameDataIdFromObject(movieInfo.toJson()), movieInfo.toJson());
  }
}
