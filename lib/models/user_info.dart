class UserInfo {
  int id;
  String sTypename;
  String name;
  String email;
  String picture;

  UserInfo({this.id, this.sTypename, this.name, this.email, this.picture});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        id: json['id'],
        sTypename: json['__typename'],
        name: json['name'],
        email: json['email'],
        picture: json['picture']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        '__typename': sTypename,
        'name': name,
        'email': email,
        'picture': picture
      };
}
