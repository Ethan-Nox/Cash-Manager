import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/pages/account_view.dart';
import 'package:frontend/pages/auth/register.dart';
import 'package:frontend/pages/cart_view.dart';
import 'package:frontend/providers/navbar_provider.dart';
import 'package:frontend/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/pages/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // String? token;
  int _selectedIndex = 0;
  final Tabs = [
    Center(
      child: SearchView(),
    ),
    const Center(
      child: AccountView(),
    ),
    const Center(
      child: CartView(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Tabs[_selectedIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     backgroundColor: Colors.blue,
    //     type: BottomNavigationBarType.fixed,
    //     iconSize: 30,
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.homeView),
    //         label: 'HomeView',
    //         backgroundColor: Color.fromARGB(255, 217, 207, 207),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.shopping_cart),
    //         label: "Shopping Cart",
    //         backgroundColor: Color.fromARGB(255, 30, 28, 28),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.person),
    //         label: 'Profile',
    //         backgroundColor: Color.fromARGB(255, 91, 73, 72),
    //       ),
    //     ],
    //     currentIndex: _selectedIndex,
    //     selectedItemColor: Colors.white,
    //     onTap: _onItemTapped,
    //   ),
    // );
    return Scaffold(
      // body: Tabs[_selectedIndex],
      body: IndexedStack(
        index: _selectedIndex,
        children: Tabs,
      ),

      bottomNavigationBar: const NavbarWidget(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
