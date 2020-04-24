import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor extends InterceptorContract {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser != null) {
      String token = await firebaseUser.getIdToken();
      data.headers["Authorization"] = "Bearer $token";
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }
}
