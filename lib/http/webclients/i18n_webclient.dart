import 'dart:convert';

import 'package:Bytebank/http/interceptors/logging_interceptor.dart';
import 'package:Bytebank/http/webclient.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class I18NWebClient {
  String viewKey;

  I18NWebClient(this.viewKey);

  Future<Map<String, String>> findAll() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Response response =
        await client.get(Uri.parse(dashboardMessagesURL + viewKey + '.json'));
    final Map<String, String> decodedJson =
        Map.castFrom(jsonDecode(response.body));
    return decodedJson;
  }
}
