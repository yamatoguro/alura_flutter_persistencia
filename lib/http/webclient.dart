import 'package:Bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String transactionsURL = 'http://192.168.0.159:8080/transactions';
const String dashboardMessagesURL =
    'https://gist.githubusercontent.com/yamatoguro/f153c641a32556966658736aa5247e5b/raw/37b3a56038e64b49d6a80ffedd124728e1fe424b/';

Client client = InterceptedClient.build(
  interceptors: [
    LoggingInterceptor(),
  ],
  requestTimeout: const Duration(seconds: 5),
);
