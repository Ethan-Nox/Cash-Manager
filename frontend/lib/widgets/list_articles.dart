// ignore_for_file: unnecessary_const, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/service/cartService.dart';
import 'package:provider/provider.dart';

class List_Article extends StatefulWidget {
  final String name;
  final double price;
  final String image;
  final String category;
  late int stock;
  final int id;
  final String description;

  List_Article(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.category,
      required this.stock});

  @override
  State<List_Article> createState() => _List_ArticleState();
}

class _List_ArticleState extends State<List_Article> {
  var cartService = CartService();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Color.fromARGB(255, 169, 168, 168),
              width: 1,
            ),
          ),
          height: 100,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.white,
                child: Image.network(
                    "http://20.111.52.214:8080/images/${widget.image}"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.category,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    '${widget.price} ???',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 30,
                  color: Color.fromARGB(255, 165, 53, 122),
                ),
                onPressed: () async {
                  LocalStorageService localStorageService =
                      LocalStorageService();
                  var token = await localStorageService.getToken();
                  cartService.addToCart(widget.id, 1, token!);

                  var list = cartService.addToCart(widget.id, 1, token!);
                  // print('list');
                  // print(list);
                  Provider.of<CartProvider>(context, listen: false)
                      .setCart(list);
                  // context
                  //     .read<CartProvider>()
                  //     .addArticle(widget.id,widget.description,widget.name, widget.price, widget.image, widget.category,  widget.stock);
                  print("add article");

                  var a = Provider.of<CartProvider>(context, listen: false)
                      .getCart();

                  if (widget.stock > 0) {
                    widget.stock--;
                  } else {
                    print('No more stock');
                  }
                },
              )
            ],
          ),
        ));
  }
}
