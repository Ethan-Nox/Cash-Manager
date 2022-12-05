import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/pages/auth/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/pages/articles/categorie.dart';

class Panier extends StatefulWidget {
  Panier({Key? key}) : super(key: key);
  @override
 

  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  String? token;
  int _selectedIndex = 0;
  final Tabs = [
     Center( 
     child:  Categorie(),
     
    ),
       const Center(
      child: Text('Profile'),
    ),
    const Center(
      child: Text('Cart'),
    ),

  ];

  static const IconData shopping_cart = IconData(0xe59c, fontFamily: 'MaterialIcons');

  @override
void initState() {
    super.initState();
    LocalStorageService localStorageService = LocalStorageService();
    localStorageService.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      
        body:  Tabs[_selectedIndex],
               bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.blue,
                type: BottomNavigationBarType.fixed,
                iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 217, 207, 207),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Shopping Cart",
           
            backgroundColor: Color.fromARGB(255, 30, 28, 28),
          ),
          
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 91, 73, 72),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      ),
    );

  }

    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
  

 
}
