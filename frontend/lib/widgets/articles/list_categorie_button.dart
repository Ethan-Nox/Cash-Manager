import 'package:flutter/material.dart';

class List_Categorie extends StatelessWidget {

  final String categorie;

  const List_Categorie({super.key, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: () {},
        child:  Text(categorie),
      ),
    );
  }


}
