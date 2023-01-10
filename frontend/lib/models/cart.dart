import 'package:frontend/models/articleModel.dart';

class Cart {
 Article_Model article;
  int quantity;

  Cart({required this.article, required this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      article: Article_Model.fromJson(json['article']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'article': article,
    'quantity': quantity,
  };

  
  
}