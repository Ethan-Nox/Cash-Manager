import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/pages/auth/register.dart';
import 'package:frontend/pages/home_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 203, 33, 209),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 300,
              height: 80,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("Clicked on Login");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 190, 134, 35),
                      minimumSize: const Size(150, 40),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Clicked on Register");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: const Text('Register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 203, 33, 209),
                      minimumSize: const Size(150, 40),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            const SizedBox(
              width: 300,
              height: 20,
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              height: 20,
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 203, 33, 209),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: loginUser,
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 5,
              width: 300,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color.fromARGB(255, 9, 9, 9)),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/google_logo.png',
                      width: 80, height: 30),
                  const SizedBox(width: 30),
                  Image.asset('assets/images/Apple-logo.png',
                      width: 80, height: 30),
                  const SizedBox(width: 30),
                  Image.asset('assets/images/mocrosoft.png',
                      width: 80, height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginUser() async {
    print("Login User");
    var https = dotenv.env['HTTPS'];
    String url = "$https/login";
    var msg = jsonEncode({
      "email": emailController.text,
      "password": passwordController.text,
    });
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: msg);

      // ignore: avoid_print
      print("Response body: ${response.body}");
      final Map parsed = json.decode(response.body);
      print(parsed['token']);
      print(parsed['user']);
      print(parsed['token']['access_token']);
      String token = parsed['token']['access_token'];

      LocalStorageService localStorageService = LocalStorageService();
      localStorageService.setToken(token);

      // final Map user = parsed['user'];
      // print(user['firstname']);
      // print(user['lastname']);
      // print(user['email']);
      // print(user['birthdate']);
      // print(user['genre']);
      // print(user['role']);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
