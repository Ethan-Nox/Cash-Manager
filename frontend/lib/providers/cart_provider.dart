import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/articleModel.dart';
import 'package:frontend/models/cart.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {





  late int _quantity = 0;
  late int id;
  late String _name;
  late double _price;
  late String _image;
  late String _category;
  late int _stock;
  late int _total;

  late List<Article_Model> items = [];

  List<Cart> cart = [];

  int get quantity{
    return _quantity;
  }

  void addQuantity(id) {
    if (id == id) {
      _quantity++;
      notifyListeners();
    }
  }

  void removeQuantity() {
    _quantity--;
    notifyListeners();
  }

  void addArticle(int id, String description, String name, double price,
      String image, String category, int stock, ) {
    _name = name;
    _price = price;
    _image = image;
    _category = category;
    _stock = stock;
    _quantity = quantity;
    _total = _quantity + _price.toInt();
    notifyListeners();

// check if the item is already in the cart

    for (var i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        _quantity++;
        return;
      }
      // else {
      //   print('else');
      //   _quantity = 1;
      // }
    }

    items.add(Article_Model(
        name: _name,
        price: _price,
        image: _image,
        category: _category,
        stock: _stock,
        description: description,
        id: id));

        cart.add(Cart(
          id: id,
          quantity: _quantity,
        )
        );

    print('object');
    print(items);


  }



  void deleteArticle(int id) {
    print('delete');
    _quantity = 0;
    for (var i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        items.removeAt(i);
        cart.removeAt(i);
      }
    }
    notifyListeners();
  }

  List<Article_Model> getItems() {
    return items;
  }
}
