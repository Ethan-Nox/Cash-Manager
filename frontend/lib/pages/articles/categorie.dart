import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/pages/articles/square.dart';

class Categorie extends StatefulWidget {
  Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  String? token;
   List<String>? categories;
  final List articles = [
    {
      "name": "Fruits",
      "stock": 100,
      "image": "https://medias.toutelanutrition.com/blog/2020/08/banner-fruits.jpg",
      "id": "b46df330-d232-4be3-9c1e-81ff71a66789"
    },
    {
      "name": "Légumes",
      "stock": 100,
      "image": "https://img-3.journaldesfemmes.fr/HwUgYMFAXpGcR9A7Xrw4oF67Mf4=/1500x/smart/409e102e633d42759746f73e286431a3/ccmcms-jdf/11057068.jpg",
      "id": "7c6e6bf2-375a-40a5-aec0-f3b46f1a2a00"
    }
  ];

  @override
  void initState() {
    super.initState();
    LocalStorageService localStorageService = LocalStorageService();
    localStorageService.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    localStorageService.getCategories().then((value) {
      setState(() {
        categories = value;
      });
    });
  
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                          category: articles[index]['name'],
                          stock: articles[index]['stock'].toString(),
                          image: articles[index]['image'],
                        ),
                        
                      ],
                    );
                  }),
            ),
        const SizedBox(height: 20),
        Row(
          children:  [
             const SizedBox(
              width: 10,
            ),
           const SizedBox(
              height: 50, 
              width: 300,
              child: TextField(
                
                    decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white, 
                     
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                      
                    ),
                ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 50, 
              width: 80,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Scan'),
              ),
            ),
          ],
        ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: categories != null,
                child: Container(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Go with it',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  

}
