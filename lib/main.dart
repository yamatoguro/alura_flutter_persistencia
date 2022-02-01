import 'package:Bytebank/components/localization.dart';
import 'package:Bytebank/components/theme.dart';
import 'package:Bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogBloc extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('${bloc.runtimeType} > $change');
    super.onChange(bloc, change);
  }
}

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(BytebankApp());
    },
    blocObserver: LogBloc(),
  );
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: bytebankTheme,
      home: LocalizationContainer(child: DashboardContainer()),
    );
  }
}
