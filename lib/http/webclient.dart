import 'dart:convert';

import 'package:Bytebank/models/contact.dart';
import 'package:Bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Future<List<Transaction>> findAll() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response r = await client
      .get(
        Uri.http('192.168.0.159:8080', 'transactions'),
      )
      .timeout(const Duration(seconds: 5));
  List<dynamic> list = jsonDecode(r.body);
  List<Transaction> tlist = [];
  for (Map<String, dynamic> item in list) {
    tlist.add(
      Transaction(
        item['value'],
        Contact(
          0,
          item['contact']['name'],
          item['contact']['account'],
        ),
      ),
    );
  }
  return tlist;
}

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
