import 'dart:convert';


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/articleModel.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../providers/cart_provider.dart';

class CartService {
  
   var https = dotenv.env['HTTPS'];

   addToCart(int article_id, int quantity, String token) async {

    final queryParameters = {
      'article_id': article_id,
      'quantity': quantity,
    };
     // add queryParameters to the query string

    // var uri = Uri.parse('$https', 'add_article', queryParameters);
  var response = await http.patch(Uri.parse('$https/add_article?article_id=$article_id&quantity=$quantity'), 
    
     headers: {
      "Content-Type": "application/json",
      "token": token,
    }); 
   
      if (response.statusCode == 200) {
        var cart = json.decode(response.body) as List;
        // ignore: avoid_print
        print(cart);
        return cart
            .map((cart) => Cart.fromJson(cart))
            .toList();
      } 
    
      else {
        throw Exception('Failed to load cart');
      }
   }









}
