import 'package:Bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String baseURL = 'http://192.168.0.159:8080/transactions';

Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
