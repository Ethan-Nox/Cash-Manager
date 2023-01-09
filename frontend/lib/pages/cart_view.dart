import 'package:flutter/material.dart';
import 'package:frontend/widgets/scan/scan.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/widgets/list_panier.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List item = Provider.of<CartProvider>(context, listen: false).getItems();

  final List items = [
    {
      "price": 100.0,
      "name": "Air force 1",
      "description": "Basket",
      "category": "Chaussure",
      "image":
          "https://www.courir.com/on/demandware.static/-/Sites-master-catalog-courir/default/dw2bc08c65/images/hi-res/001498199_101.png",
      "stock": 100,
      "id": 2
    },
    {
      "price": 350.0,
      "name": "Iphone 11",
      "description": "telephone apple",
      "category": "Apple",
      "image":
          "https://boostit.cdiscount.com/wp-content/uploads/2020/05/iPhone11_Visuel1-DM-1.png",
      "stock": 50,
      "id": 1
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: scan(),
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
                  id: item[index].id,
                  name: item[index].name,
                  price: item[index].price,
                  image: item[index].image,
                  description: item[index].description,
                  category: item[index].category,
                  stock: item[index].stock,
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
