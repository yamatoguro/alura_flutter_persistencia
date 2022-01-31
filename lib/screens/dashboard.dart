import 'package:Bytebank/screens/contacts_list.dart';
import 'package:Bytebank/screens/name.dart';
import 'package:Bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends StatelessWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Iago'),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      _FeatureItem(
                        name: 'Transfer',
                        icon: Icons.monetization_on,
                        onClick: () => _showContactsList(context),
                      ),
                      _FeatureItem(
                        name: 'Transaction Feed',
                        icon: Icons.description,
                        onClick: () => _showTransactionList(context),
                      ),
                      _FeatureItem(
                        name: 'Change Name',
                        icon: Icons.person_outline,
                        onClick: () => _showChangeName(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsList(),
      ),
    );
  }

  _showTransactionList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }

/*

Navigator.push(context, MaterialPageRoute(builder: (context) {
  return BlocProvider<MyBloc>.value(
    value: BlocProvider.of<MyBloc>(context),
    child: SecondScreen(context),
  );
}));


 */
  void _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(blocContext),
          child: NameContainer(),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.green[900],
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
