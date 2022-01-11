import 'dart:convert';

import 'package:Bytebank/components/dialog.dart';
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
    final Response response = await client
        .get(Uri.parse(baseURL))
        .timeout(const Duration(seconds: 5));
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
    switch (r.statusCode) {
      case 400:
        showDialog(
          context: context,
          builder: (context) => const DialogCustom(
            title: 'Error 400',
            content: 'There was an error submitting transaction',
          ),
        );
        throw Exception('Error 400: There was an error submitting transaction');
      case 401:
        showDialog(
          context: context,
          builder: (context) => const DialogCustom(
            title: 'Error 401',
            content: 'Authentication failed',
          ),
        );
        throw Exception('Error 401: Authentication failed');
      case 200:
        Map<String, dynamic> resultJSON = jsonDecode(r.body);
        return Transaction.fromJson(resultJSON);
      default:
        throw Exception('Unknown error');
    }
  }
}
