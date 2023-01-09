import 'package:flutter/material.dart';
import 'package:frontend/widgets/scan/scan.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: scan(),
        body: Center(
          child: Text("Cart"),
        ),
      ),
    );
  }
}
