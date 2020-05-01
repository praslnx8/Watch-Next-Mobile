class MovieQuery {
  static String trendingMoviesQuery = r'''
  query trendingMovies {
    me {
    getTrendingMovies {
        id,
        title,
        description,
        backDrops,
        posters,
        images,
        genres,
        releasedDate,
        rating,
        noOfRating,
        adultContent
    }
    }
  }
  ''';

  static String moviesQuery = r'''
  query movie {
    getMovie(id) {
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
