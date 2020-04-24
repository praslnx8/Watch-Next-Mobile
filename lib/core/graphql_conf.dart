import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:movie_suggestion/core/log_interceptor.dart';

class GraphQLConfiguration {
  static Client _client =
      HttpClientWithInterceptor.build(interceptors: [LogInterceptor()]);

  static HttpLink _httpLink =
      HttpLink(uri: "http://10.0.2.2:8080/graphql", httpClient: _client);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: _httpLink,
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: _httpLink,
      cache: InMemoryCache(),
    );
  }
}
