import 'package:http_interceptor/http_interceptor.dart';
import 'package:movie_suggestion/utils/app_logger.dart';

class LogInterceptor extends InterceptorContract {

  LogInterceptor() {
    print("interceptor");
  }

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {

    print("interceptor req");
    print(data.url);
    AppLogger.get().i("INTERCEPTOR: REQ");
    AppLogger.get().i(data.url);
    AppLogger.get().i(data.headers);
    AppLogger.get().i("---");
    print(data.url);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    AppLogger.get().i("INTERCEPTOR: RESP");
    AppLogger.get().i(data.url);
    AppLogger.get().i(data.headers);
    AppLogger.get().i(data.toHttpResponse().statusCode);
    AppLogger.get().i(data.toHttpResponse().body);
    AppLogger.get().i("----------");
    return data;
  }
}
