class MovieQuery {
  static String trendingMoviesQuery = r'''
  query trendingMovies {
    me {
      id,
      __typename,
      getTrendingMovies {
        id,
        __typename,
        title,
        description,
        backDrops,
        posters,
        images,
        genres,
        releasedDate,
        rating,
        noOfRating,
        adultContent,
        myRating,
        addedAsWatchLater
      }
    }
  }
  ''';

  static String rateMovie = r'''
  mutation rateMovie($movieId: Long!, $rating: Int!) {
    me {
      rateMovie(movieId: $movieId, rating: $rating)
    }
  }
  ''';

  static String addMovieToWatchLater = r'''
  mutation addMovieToWatchLater($movieId: Long!, $add: Boolean!) {
    me {
      addMovieToWatchLater(movieId: $movieId, add: $add)
    }
  }
  ''';
}
