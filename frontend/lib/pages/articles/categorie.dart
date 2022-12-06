import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/widgets/square.dart';

class Categorie extends StatefulWidget {
  Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 207, 207),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Square(
                        category: articles[index]['category'],
                        stock: articles[index]['stock'].toString(),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 400,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Elevated Button',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
