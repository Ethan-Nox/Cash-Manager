import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/auth/login.dart';
import 'package:frontend/providers/page_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (context) => PageProvider()),
  //   ],
  //   child: const MyApp(),
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
    // return ChangeNotifierProvider<PageProvider>(
    //     create: (context) => PageProvider(),
    //     child: Consumer<PageProvider>(
    //       builder: (context, themeProvider, child) => MaterialApp(
    //         title: 'Flutter Provider Demo',
    //         theme: ThemeData(
    //           primarySwatch: Colors.blue,
    //           appBarTheme: AppBarTheme(brightness: Brightness.dark),
    //         ),
    //         home: MainScaffold(),
    //       ),
    //     ),
    //   );
  }
}
