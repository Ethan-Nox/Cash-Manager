import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/articleModel.dart';
import 'package:frontend/models/cart.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {


  late List<Cart> cart = [];

  Future<void>  setCart(Future<List<Cart>> newcart) async {
    cart = await newcart;
    notifyListeners();
  }

  List<Cart> getCart() {
    return cart;
  }
}
