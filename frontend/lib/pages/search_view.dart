import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/widgets/articles/list_categorie_button.dart';



class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchState();
}


class _SearchState extends State<SearchView> {
  final List articles = [
    {
      "price": 100,
      "name": "Air force 1",
      "description": "Basket",
      "category": "Chaussure",
      "stock": 100,
      "id": "b46df330-d232-4be3-9c1e-81ff71a66789"
    },
    {
      "price": 350,
      "name": "Iphone 11",
      "description": "telephone apple",
      "category": "Apple",
      "stock": 50,
      "id": "7c6e6bf2-375a-40a5-aec0-f3b46f1a2a00"
    }
  ];


  @override
  Widget build(BuildContext context) {

    return 
     Scaffold(
      appBar: AppBar(
        
      ),
      body:   Container(
        height: 170,
          padding: const EdgeInsets.all(2.0),
        child: Column(  
          children: [
            Container(
              height: 100,
              color: Colors.blue[100],
              child: const Center(
                child: Text("Categorie"),
              ),
            ),
          ],
        ),
      ),
    );

   

  }
}
