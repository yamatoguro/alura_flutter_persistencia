import 'package:Bytebank/components/container.dart';
import 'package:Bytebank/models/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameContainer extends StatelessWidget {
  const NameContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends BlocContainer {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change name'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Desired name',
            ),
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                child: const Text('Change'),
                onPressed: () {
                  final name = _nameController.text;
                  context.read<NameCubit>().change(name);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
