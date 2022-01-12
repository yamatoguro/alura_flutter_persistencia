// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:async';

import 'package:Bytebank/components/response_dialog.dart';
import 'package:Bytebank/components/transaction_auth_dialog.dart';
import 'package:Bytebank/http/webclients/transaction_webclient.dart';
import 'package:Bytebank/models/contact.dart';
import 'package:Bytebank/models/transaction.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebclient _webclient = TransactionWebclient();
  bool _processing = false;

  @override
  Widget build(BuildContext context) => LoadingOverlay(
        child: buildTransactionForm(context),
        isLoading: _processing,
        opacity: 0.7,
        progressIndicator: const CircularProgressIndicator(),
        color: Colors.green,
      );

  Widget buildTransactionForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (password) {
                            final double? value =
                                double.tryParse(_valueController.text);
                            final transactionCreated = Transaction(
                                value: value, contact: widget.contact);
                            _save(transactionCreated, password, context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction t, String password, BuildContext context) async {
    try {
      setState(() => _processing = true);
      Transaction tr = await _webclient.save(t, password, context);
      if (tr != null) {
        setState(() {
          _processing = false;
        });
        await _showMessage(context, true);
        Navigator.pop(context);
      }
    } on HttpException catch (e) {
      setState(() {
        _showMessage(context, false, message: e.message);
        _processing = false;
      });
    } on TimeoutException {
      setState(() {
        _showMessage(context, false, message: 'Timeout submitting transaction');
        _processing = false;
      });
    } catch (e) {
      setState(() {
        _showMessage(context, false);
        _processing = false;
      });
    }
  }

  Future<dynamic> _showMessage(
    BuildContext context,
    bool success, {
    String message = 'Unknown error',
  }) {
    return (success)
        ? showDialog(
            context: context,
            builder: (dialogContext) => SuccessDialog('Successful transaction'),
          )
        : showDialog(
            context: context,
            builder: (context) => FailureDialog(message),
          );
  }
}
