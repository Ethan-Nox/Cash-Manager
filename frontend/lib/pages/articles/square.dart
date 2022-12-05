import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';

class Square extends StatefulWidget {
  final String category;
  final String stock;
  static const IconData check = IconData(0xe156, fontFamily: 'MaterialIcons');

  Square({required this.category, required this.stock});

  @override
  State<Square> createState() => _SquareState();
}

class _SquareState extends State<Square> {
  late var isClicked = false;

  @override
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
                          width: 80,
                          height: 80,
                          color: Colors.grey,
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
    print(isClicked);
    print(widget.category);
  }
}
