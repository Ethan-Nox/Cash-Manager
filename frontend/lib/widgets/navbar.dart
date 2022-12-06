import 'package:flutter/material.dart';
import 'package:frontend/providers/page_provider.dart';
import 'package:provider/provider.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({Key? key}) : super(key: key);

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });
    Provider.of<PageProvider>(context).changePage(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
