import 'package:flutter/material.dart';
import 'package:movie_suggestion/models/movie_info.dart';
import 'package:movie_suggestion/widgets/poster.dart';
import 'package:movie_suggestion/widgets/rating_information.dart';

import 'arc_banner_image.dart';

class MovieCard extends StatefulWidget {
  final MovieInfo movieInfo;

  MovieCard([this.movieInfo]);

  @override
  _MovieCardState createState() => _MovieCardState(movieInfo);
}

class _MovieCardState extends State<MovieCard> {
  final MovieInfo movieInfo;

  _MovieCardState([this.movieInfo]);

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
        RatingInformation(movieInfo),
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
          child: ArcBannerImage(movieInfo.images[0]),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Poster(
                movieInfo.images[1],
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
}
