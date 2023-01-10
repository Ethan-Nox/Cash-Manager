import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/widgets/list_panier.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List item = Provider.of<CartProvider>(context, listen: true).getCart();

  // final List item = [
  //    {
  //   "article": {
  //     "price": 0,
  //     "name": "string",
  //     "description": "string",
  //     "category": "string",
  //     "stock": 0,
  //     "id": 0,
  //     "image": "string"
  //   },
  //   "quantity": 0
  // },
  // {
  //   "article": {
  //     "price": 0,
  //     "name": "string",
  //     "description": "string",
  //     "category": "string",
  //     "stock": 0,
  //     "id": 0,
  //     "image": "string"
  //   },
  //   "quantity": 0
  // },
  // ];

  // @override
  // void initState() {
  //   super.initState();
  //   print("afficher la liste des produit");
  //   print(item);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: ListView(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: item.length,
              itemBuilder: (context, index) {
                return List_Panier(
                  id: item[index]["article"].id,
                  name: item[index]["article"].name,
                  price: item[index]["article"].price,
                  image: item[index]["article"].image,
                  category: item[index]["article"].category,
                  stock: item[index]["article"].stock,
                  description: item[index]["article"].description,
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
