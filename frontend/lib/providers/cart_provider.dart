import 'package:flutter/material.dart';
import 'package:frontend/models/articleModel.dart';

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

  int get quantity => _quantity;

  void addArticle(int id, String description, String name, double price,
      String image, String category, int stock) {
    _quantity++;
    _name = name;
    _price = price;
    _image = image;
    _category = category;
    _stock = stock;
    _total = _quantity + _price.toInt();
    notifyListeners();

    items.add(Article_Model(
        name: _name,
        price: _price,
        image: _image,
        category: _category,
        stock: _stock,
        description: '',
        id: 0));

    print('object');
    print(items);
  }

  List<Article_Model> getItems() {
    return items;
  }



}
