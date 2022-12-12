import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/widgets/articles/list_categorie_button.dart';



class Categorie extends StatefulWidget {
  Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

final List list_Categorie = [
  "Hi-Tech",
  "Vetement",
  "Sport",
  "Jouet",
  "Maison",
  "Materiel"
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
            Expanded(
              child: ListView.builder(
                itemCount: list_Categorie.length,
                itemBuilder: (context, index) {
                return  Column(
                  children: [
                    List_Categorie(categorie: list_Categorie[index]),
                    const Divider(
                      color: Colors.black,
                    ),
                  ],
                 );
                },
                scrollDirection: Axis.horizontal,
               
              ),
            ),

           

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
