import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/app.dart';
import 'package:frontend/pages/auth/login.dart';

import 'package:frontend/pages/home_view.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/providers/navbar_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NavBarProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider() ),
        ],
        child: MaterialApp(
          title: 'Cash Manager',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const App(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
