class UserInfo {
  String name;
  String email;
  String picture;

  UserInfo({this.name, this.email, this.picture});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'], email: json['email'], picture: json['picture']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'picture': picture};
}
