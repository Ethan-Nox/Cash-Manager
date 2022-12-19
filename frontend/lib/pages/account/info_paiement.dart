import 'package:flutter/material.dart';

class InfoPaiementPage extends StatefulWidget {
  const InfoPaiementPage({super.key});

  @override
  State<InfoPaiementPage> createState() => _InfoPaiementPageState();
}

class _InfoPaiementPageState extends State<InfoPaiementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations de paiement'),
      ),
      body: const Center(
        child: Text('Info paiement Page'),
      ),
    );
  }
}
