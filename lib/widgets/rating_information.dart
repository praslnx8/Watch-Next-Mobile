import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_suggestion/models/movie_info.dart';
import 'package:movie_suggestion/models/user_info.dart';
import 'package:movie_suggestion/queries/movie_query.dart';

class RatingInformation extends StatelessWidget {
  final UserInfo userInfo;
  final MovieInfo movie;

  RatingInformation(this.userInfo, this.movie);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption.copyWith(color: Colors.black45);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          movie.rating.toString(),
          style: textTheme.title.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.accentColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Ratings',
          style: ratingCaptionStyle,
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Mutation(
            options: MutationOptions(
                documentNode: gql(MovieQuery.rateMovie), update: _updateCache),
            builder: (RunMutation runMutation, QueryResult queryResult) {
              return RatingBar(
                direction: Axis.horizontal,
                itemCount: 5,
                initialRating: _getMyRating(movie),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                    default:
                      return Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.green,
                      );
                  }
                },
                onRatingUpdate: (rating) {
                  print(rating);
                  movie.myRating = rating.toInt();
                  runMutation({'movieId': movie.id, 'rating': rating.toInt()});
                },
              );
            }),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            'Rate now',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        numericRating,
        SizedBox(width: 16.0),
        starRating,
      ],
    );
  }

  _getMyRating(MovieInfo movie) {
    if (movie.myRating != null) {
      return movie.myRating.toDouble();
    } else {
      return 0.0;
    }
  }

  void _updateCache(Cache cache, QueryResult result) {
    cache.write(typenameDataIdFromObject(movie.toJson()), movie.toJson());
  }
}
