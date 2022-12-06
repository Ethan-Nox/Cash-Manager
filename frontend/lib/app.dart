import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/account_view.dart';
import 'package:frontend/pages/auth/login.dart';
import 'package:frontend/pages/cart_view.dart';
import 'package:frontend/pages/home_view.dart';
import 'package:frontend/providers/navbar_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/widgets/articles/categorie.dart';
import 'package:frontend/widgets/navbar-v2.dart';
import 'package:frontend/widgets/navbar.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    int currentPageIndex =
        Provider.of<NavBarProvider>(context, listen: true).currentPageIndex;
    User? currentUser =
        Provider.of<UserProvider>(context, listen: true).currentUser;

    return Scaffold(
        // bottomNavigationBar: const NavbarWidget(),
        bottomNavigationBar: const MyNavBar(),
        body: IndexedStack(
          index: currentPageIndex,
          children: <Widget>[
            currentUser == null ? const Login() : Categorie(),
            currentUser == null ? const Login() : const CartView(),
            currentUser == null ? const Login() : const AccountView(),
          ],
        ));
  }
}
