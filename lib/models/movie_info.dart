class MovieInfo {
  int id;
  String title;
  String description;
  List<String> backDrops;
  List<String> posters;
  List<String> images;
  List<String> genres;
  int releasedDate;
  double rating;
  int noOfRating;
  bool adultContent;

  MovieInfo({this.id,
    this.title,
    this.description,
    this.images,
    this.genres,
    this.releasedDate,
    this.rating,
    this.noOfRating,
    this.adultContent});

  MovieInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    backDrops = json['backDrops'].cast<String>();
    posters = json['posters'].cast<String>();
    images = json['images'].cast<String>();
    genres = json['genres'].cast<String>();
    releasedDate = json['releasedDate'];
    rating = json['rating'];
    noOfRating = json['noOfRating'];
    adultContent = json['adultContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['backDrops'] = this.backDrops;
    data['posters'] = this.posters;
    data['images'] = this.images;
    data['genres'] = this.genres;
    data['releasedDate'] = this.releasedDate;
    data['rating'] = this.rating;
    data['noOfRating'] = this.noOfRating;
    data['adultContent'] = this.adultContent;
    return data;
  }

  static List<MovieInfo> getMovieInfoList(dynamic json) {
    final movies = new List<MovieInfo>();
    json.forEach((v) {
      movies.add(MovieInfo.fromJson(v));
    });

    return movies;
  }
}
