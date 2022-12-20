import 'package:flutter/material.dart';
import 'package:frontend/pages/account/user_infos.dart';
import 'package:frontend/widgets/historique/facture.dart';
import 'package:frontend/widgets/historique/historique_bloc.dart';
import 'package:intl/intl.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  List data = [
    {
      'date': '29-11-2021',
      'refPaiement': '123456789',
      'price': '1000',
      "bill": "File1"
    },
    {
      'date': '03-12-2021',
      'refPaiement': '100000001',
      'price': '29',
      "bill": "File2"
    },
    {
      'date': '09-12-2021',
      'refPaiement': '100000002',
      'price': '56',
      "bill": "File3"
    }
  ];
  final growableList = <String>['A', 'B'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des commandes'),
      ),
      body: Column(
        children: [
          HistoriqueWidget(
            date: DateTime.now(),
            price: '19',
            refPaiement: '123456789',
            description: 'courte description du produit',
            title: 'Rolex',
            onTap: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FactureWidget(
                            target: 'clock-removebg-preview.png',
                            date: DateFormat('yyyy-MM-dd – kk:mm')
                                .format(DateTime.now()),
                          )),
                )),
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: data.length,
      //   itemBuilder: (context, index) {
      //     return HistoriqueWidget(
      //       date: DateTime.now(),
      //       price: data[index]['price'],
      //       refPaiement: data[index]['refPaiement'],
      //       description: data[index]['bill'],
      //       title: data[index]['date'],
      //     );
      //   },
      // ),
    );
  }
}
