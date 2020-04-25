class LoginQuery {
  static String loginQuery = r'''
  mutation login($idToken: String!) {
    login(idToken: $idToken) {
      name
    }
  }
  ''';
}
