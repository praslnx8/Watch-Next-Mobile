import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:http_interceptor/http_interceptor.dart';
import 'package:movie_suggestion/core/auth_util.dart';
import 'package:movie_suggestion/core/log_interceptor.dart';

class GraphQLConfiguration {
  static final _client =
      HttpClientWithInterceptor.build(interceptors: [LogInterceptor()]);

  static final _httpLink =
      HttpLink(uri: "http://10.0.2.2:8080/graphql", httpClient: _client);

  static final _authLink = AuthLink(getToken: () async {
    final token = await AuthUtil.getToken();
    return "Bearer $token";
  });

  static final _link = _authLink.concat(_httpLink);

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: _link,
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    ),
  );
}
