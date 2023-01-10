import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/models/articleModel.dart';
import 'package:frontend/pages/filter_view.dart';
import 'package:frontend/pages/sort_view.dart';
import 'package:frontend/service/article.dart';
import 'package:frontend/widgets/articles/list_categorie_button.dart';
import 'package:frontend/widgets/list_articles.dart';
import 'package:http/http.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchState();
}

class _SearchState extends State<SearchView> {
  String? token;
  Future<List<dynamic>>? article;

  // List articles //

  List articles = [
    {
      "price": 100,
      "name": "Air force 1",
      "description": "Basket",
      "category": "Chaussure",
      "image":
          "https://www.courir.com/on/demandware.static/-/Sites-master-catalog-courir/default/dw2bc08c65/images/hi-res/001498199_101.png",
      "stock": 100,
      "id": "b46df330-d232-4be3-9c1e-81ff71a66789"
    },
    {
      "price": 350,
      "name": "Iphone 11",
      "description": "telephone apple",
      "category": "Apple",
      "image":
          "https://boostit.cdiscount.com/wp-content/uploads/2020/05/iPhone11_Visuel1-DM-1.png",
      "stock": 50,
      "id": "7c6e6bf2-375a-40a5-aec0-f3b46f1a2a00"
    }
  ];

  static const IconData arrow_forward =
      IconData(0xe09b, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        // Boutton sort and filter  //
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      builder: (context) => const SizedBox(
                        height: 500,
                        child: Sort_View(),
                      ),
                    );
                  },
                  label: const Text("Sort"),
                  icon: const Icon(
                    Icons.sort,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(150, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
              ElevatedButton.icon(
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      builder: (context) => Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 163, 110, 110),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        height: 500,
                        child: Filter_View(),
                      ),
                    );
                  },
                  label: const Text("Filter"),
                  icon: const Icon(
                    Icons.filter_list,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(150, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
            ],
          ),
        ),
        FutureBuilder<List<dynamic>>(
            future: article,
            builder: (context, snapshot) {
              print("snapshot.data");
              print(article);
           
              print(snapshot);

              article?.then((value) => print(value));

              print("has data---------------------------");
            
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot);
                if (snapshot.data == null) {
                  return const Text("No data");
                } else {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return List_Article(
                          id: snapshot.data![index].id,
                          name: snapshot.data![index].name,
                          price: snapshot.data![index].price,
                          image: snapshot.data![index].image,
                          description: snapshot.data![index].description,
                          category: snapshot.data![index].category,
                          stock: snapshot.data![index].stock,
                        );
                      },
                    ));
                  }
                }
              } else if (snapshot.hasError) {
                return const Text("Error");
              }
              return const CircularProgressIndicator();
            }),

        //  Search bar  //
        Container(
          margin:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
          child: Row(
            children: [
              const SizedBox(
                height: 50,
                width: 280,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search)),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 165, 53, 122),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: Text("Scan"),
                ),
              )
            ],
          ),
        ),
      ],
    )));
  }

  // function to get the token //
  void getToken() async {
    LocalStorageService localStorageService = LocalStorageService();
    token = await localStorageService.getToken();
    setState(() {
      this.token = token;
    });
    // print("---------------------------------");
    // print(token);
    // print("---------------------------------");
    article = ArticleService().getArticles(token!);
    article!.then(
      (value) => print(value),
    );

    // print(article);
  }
}
