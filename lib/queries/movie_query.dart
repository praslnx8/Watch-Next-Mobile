class MovieQuery {
  static String trendingMoviesQuery = r'''
  query trendingMovies {
    getTrendingMovies {
        id,
        title,
        description,
        images,
        genres,
        releasedDate,
        rating,
        noOfRating,
        adultContent
    }
  }
  ''';
}
