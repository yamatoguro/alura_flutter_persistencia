import 'dart:convert';

import 'package:Bytebank/components/response_dialog.dart';
import 'package:Bytebank/http/interceptors/logging_interceptor.dart';
import 'package:Bytebank/http/webclient.dart';
import 'package:Bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Response response = await client.get(Uri.parse(baseURL));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions =
        decodedJson.map((e) => Transaction.fromJson(e)).toList();
    return transactions;
  }

  Future<Transaction> save(
      Transaction t, String password, BuildContext context) async {
    Response r = await client.post(
      Uri.parse(baseURL),
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: jsonEncode(t.toJson()),
    );
    if (r.statusCode == 200) {
      Map<String, dynamic> resultJSON = jsonDecode(r.body);
      return Transaction.fromJson(resultJSON);
    }

    throw HttpException(_statusCodeResponses[r.statusCode]!);
  }

  static final Map<int, String> _statusCodeResponses = {
    0: 'Unknown error',
    400: 'There was an error submitting transaction',
    401: 'Authentication failed'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
