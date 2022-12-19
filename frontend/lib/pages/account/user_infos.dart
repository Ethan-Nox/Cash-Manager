import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserInfosPage extends StatefulWidget {
  const UserInfosPage({super.key});

  @override
  State<UserInfosPage> createState() => _UserInfosPageState();
}

class _UserInfosPageState extends State<UserInfosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes informations'),
      ),
      body: const Center(
        child: Text('User Infos'),
      ),
    );
  }
}
