import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';

class Square extends StatefulWidget {
  final String category;
  final String stock;
  final String image;
  static const IconData check = IconData(0xe156, fontFamily: 'MaterialIcons');

  Square({required this.category, required this.stock, required this.image});

  @override
  State<Square> createState() => _SquareState();
}

class _SquareState extends State<Square> {
  late var isClicked = false;

  @override
void initState() {
    super.initState();
    LocalStorageService localStorageService = LocalStorageService();
    localStorageService.clearCategories();
   
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                  ),
                  width: 290,
                  height: 120,
                  // color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.white, spreadRadius: 3),
                            ],
                          ),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.category),
                          const SizedBox(height: 10),
                          Text(widget.stock),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              FloatingActionButton(
                backgroundColor: isClicked ? Colors.blue : Colors.white,
                onPressed: changeColor,
                child: Icon(
                  isClicked ? Square.check : Icons.add,
                  color: isClicked ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // change the color of the button and Icon when the user clicks on it
  void changeColor() {
    setState(() {
      isClicked = !isClicked;
    });
    // if the button is clicked, add the category to the list of categories
    if (isClicked) {
      addCategory();
 
    } else {
      removeCategory();
    }
    getCategories();
    print(isClicked);
    print(widget.category.toString()); 
    print(widget.stock.toString());
  }

  // add the category to the list of categories
  void addCategory() async {
    LocalStorageService localStorageService = LocalStorageService();
    localStorageService.addCategory(widget.category);
  }

  // remove the category from the list of categories
  void removeCategory() async {
    LocalStorageService localStorageService = LocalStorageService();
    localStorageService.removeCategory(widget.category);
  }

// get the list of categories
  void getCategories() async {
    LocalStorageService localStorageService = LocalStorageService();
    List<String> categories = await localStorageService.getCategories();
    print(categories);
    print(categories.length);
  }
}
