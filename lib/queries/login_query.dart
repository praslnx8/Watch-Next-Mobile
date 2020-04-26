class UserQuery {
  static String loginQuery = r'''
  mutation login($idToken: String!) {
    login(idToken: $idToken) {
      name
    }
  }
  ''';

  static String meQuery = r'''
  query me {
    me {
        name,
        email,
        picture
    }
  }
  ''';
}
