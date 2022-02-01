// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'container.dart';

class LocalizationContainer extends BlocContainer {
  Widget child;
  LocalizationContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider.value(
    //   value: CurrentLocaleCubit(),
    //   child: this.child,
    // );
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: this.child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("pt-br");
}

class ViewI18N {
  String language = 'pt-br';

  ViewI18N(BuildContext context) {
    this.language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  localize(Map<String, String> map) {
    assert(map != null);
    assert(map.containsKey(language));
    return map[language];
  }
}
