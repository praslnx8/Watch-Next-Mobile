class MovieInfo {
  int id;
  String sTypename;
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
  int myRating;

  MovieInfo({this.id,
    this.sTypename,
    this.title,
    this.description,
    this.images,
    this.genres,
    this.releasedDate,
    this.rating,
    this.noOfRating,
    this.adultContent,
    this.myRating});

  MovieInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
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
    myRating = json['myRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
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
    data['myRating'] = this.myRating;
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
