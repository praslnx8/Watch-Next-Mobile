import 'package:flutter/material.dart';
import 'package:movie_suggestion/models/movie_info.dart';

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
    return Text(movieInfo.title);
  }
}
