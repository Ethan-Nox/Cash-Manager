import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/app.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/providers/navbar_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['STRIPE']!;
  await Stripe.instance.applySettings();
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
