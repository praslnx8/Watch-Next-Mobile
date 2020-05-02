class UserQuery {
  static String loginQuery = r'''
  mutation login($idToken: String!) {
    login(idToken: $idToken) {
      id,
      __typename,
      name
    }
  }
  ''';

  static String meQuery = r'''
  query me {
    me {
        id,
        __typename,
        name,
        email,
        picture
    }
  }
  ''';
}
