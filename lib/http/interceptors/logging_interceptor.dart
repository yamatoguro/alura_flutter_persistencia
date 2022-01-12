import 'package:flutter/material.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('Request');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('Response');
    debugPrint('Status: ${data.statusCode}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');
    return data;
  }
}
