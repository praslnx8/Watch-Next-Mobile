import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart';

class LoggerHttpClient extends BaseClient {
  final Client _client;
  final JsonEncoder _encoder = new JsonEncoder.withIndent('  ');
  final JsonDecoder _decoder = new JsonDecoder();

  LoggerHttpClient(this._client);

  @override
  void close() {
    _client.close();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request).then((response) async {
      final responseString = await response.stream.bytesToString();

      String prettyPrint = _encoder.convert(_decoder.convert(responseString));
      final _res = '''
      responseString: $prettyPrint,
      statusCode: ${response.statusCode},
      headers: ${response.headers},
      reasonPhrase: ${response.reasonPhrase},
      persistentConnection: ${response.persistentConnection},
      requestHeaders: ${response.request.headers},
      isRedirect: response.isRedirect''';
      developer.log(_res.toString(), name: "http.client");

      if(request is Request) {
        final _body = '''
          reqBody : ${request.body}
        ''';
        developer.log(_body.toString(), name: "http.client");
      }

      return StreamedResponse(ByteStream.fromBytes(utf8.encode(responseString)),
          response.statusCode,
          headers: response.headers,
          reasonPhrase: response.reasonPhrase,
          persistentConnection: response.persistentConnection,
          contentLength: response.contentLength,
          isRedirect: response.isRedirect,
          request: response.request);
    });
  }
}