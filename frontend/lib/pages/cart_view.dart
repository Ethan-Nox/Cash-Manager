import 'package:flutter/widgets.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text('CartView'),
          ],
        ),
      ),
    );
  }
}
