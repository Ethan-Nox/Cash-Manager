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
    var article = Provider.of<CartProvider>(context, listen: false).getCart();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: ListView(   
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: article.length,
              itemBuilder: (context, index) {
                return List_Panier(
                  id: article[index].article.id,
                  name: article[index].article.name,
                  price: article[index].article.price,
                  image: article[index].article.image,
                  category: article[index].article.category,
                  stock: article[index].article.stock,
                  description: article[index].article.description,
                  quantity: article[index].quantity
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
