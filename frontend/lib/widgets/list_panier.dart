
import 'package:flutter/material.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:provider/provider.dart';


   class List_Panier extends StatefulWidget {

  final int id;
  final String name;
  final num price;
  final String image;
  final String category;
  final int stock;
  final String description;
  final int quantity;

   List_Panier({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.stock,
    required this.description,
    required this.quantity,
  });

  @override
  State<List_Panier> createState() => _List_PanierState();
}

class _List_PanierState extends State<List_Panier> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 169, 168, 168),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.network("http://20.111.52.214:8080/images/${widget.image}"),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    Text(
                      widget.category,
                      style:const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(flex: 1),
                    Text(
                      widget.price.toString(),
                      style:const  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 31, 30, 30),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                        color: const Color.fromARGB(255, 169, 168, 168),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {

                            

                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Color.fromARGB(255, 109, 87, 87),
                          ),
                        ),
                        Text(
                          widget.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 109, 87, 87),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

}


