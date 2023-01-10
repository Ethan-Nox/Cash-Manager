import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/articleModel.dart';
import 'package:http/http.dart' as http;

class ArticleService {
  var https = dotenv.env['HTTPS'];

  Future<List> getArticles(String token) async {
    var response = await http.get(Uri.parse('$https/articles'), headers: {
      "Content-Type": "application/json",
      "token": token,
    });
    if (response.statusCode == 200) {
      var articles = json.decode(response.body) as List;

      return articles
          .map((article) => Article_Model.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future getImage(String filename) async {
    var response =
        await http.get(Uri.parse('$https/images/$filename'), headers: {
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      var image = response.body.toString();
      // ignore: avoid_print
      print(image);
      return image;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
