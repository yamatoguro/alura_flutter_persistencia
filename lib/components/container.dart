import 'package:flutter/material.dart';

abstract class BlocContainer extends StatelessWidget {}

void push(BuildContext blocContext, BlocContainer container) {
  Navigator.push(
    blocContext,
    MaterialPageRoute(
      builder: (context) => container,
    ),
  );
}
