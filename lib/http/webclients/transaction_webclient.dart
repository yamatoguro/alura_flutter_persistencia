import 'dart:convert';

import 'package:Bytebank/http/interceptors/logging_interceptor.dart';
import 'package:Bytebank/http/webclient.dart';
import 'package:Bytebank/models/contact.dart';
import 'package:Bytebank/models/transaction.dart';
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
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in decodedJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Transaction> save(Transaction t) async {
    Response r = await client.post(
      Uri.parse(baseURL),
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: jsonEncode({
        'value': t.value,
        'contact': {
          'name': t.contact.name,
          'accountNumber': t.contact.accountNumber.toString(),
        }
      }),
    );
    Map<String, dynamic> resultJSON = jsonDecode(r.body);
    final Map<String, dynamic> contactJson = resultJSON['contact'];
    final Transaction transaction = Transaction(
      resultJSON['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    return transaction;
  }
}
