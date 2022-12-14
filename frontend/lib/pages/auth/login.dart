import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/auth/register.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/services/LSservices.dart';
import 'package:frontend/widgets/dialog_alert.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late String name = "";
  late String pss = "";
  late String token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 203, 33, 209),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // or Axis.vertical,
        child: Center(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
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
                  child: const Text('Connect'),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 5,
                width: 300,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 9, 9, 9)),
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
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 126, 126, 126),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () {
                    getLocalData().then((value) =>
                        value == true ? loginToken() : print("No data"));
                  },
                  child: const Text('Continue with last Account'),
                ),
              ),
            ],
          ),
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
      // print("Response body: ${response.body}");
      final Map parsed = json.decode(response.body);
      // print(parsed['token']);
      // print(parsed['user']);
      print(parsed['token']['access_token']);
      String token = parsed['token']['access_token'];

      LocalStorageService localStorageService = LocalStorageService();
      localStorageService.setToken(token);

      var newUser = User(
        firstName: parsed['user']['firstname'],
        lastName: parsed['user']['lastname'],
        email: parsed['user']['email'],
        genre: parsed['user']['genre'],
        role: parsed['user']['role'],
        birthdate: parsed['user']['birthdate'],
      );
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).setCurrentUser(newUser);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  fakeLogin(user, psswd) async {
    var https = dotenv.env['HTTPS'];
    String url = "$https/login";
    var msg = jsonEncode({
      "email": user,
      "password": psswd,
    });
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: msg);

      final Map parsed = json.decode(response.body);
      String token = parsed['token']['access_token'];
      print(token);
      LocalStorageService localStorageService = LocalStorageService();
      localStorageService.setToken(token);

      var newUser = User(
        firstName: parsed['user']['firstname'],
        lastName: parsed['user']['lastname'],
        email: parsed['user']['email'],
        genre: parsed['user']['genre'],
        role: parsed['user']['role'],
        birthdate: parsed['user']['birthdate'],
      );
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).setCurrentUser(newUser);

      setFakeDataLocalStorage(emailController.text, passwordController.text);
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'X',
            onPressed: () {
              // Code to execute.
            },
          ),
          content: const Text('Informations manquantes ou incorrectes !'),
          duration: const Duration(milliseconds: 1500),
          width: 280.0, // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  loginToken() async {
    var https = dotenv.env['HTTPS'];
    String url = "$https/login";
    String tkn = token;

    try {
      var response = await http.get(Uri.parse(url),
          headers: {"Content-Type": "application/json", "token": tkn});

      final Map parsed = json.decode(response.body);
      String token = parsed['token']['access_token'];
      print(token);
      LocalStorageService localStorageService = LocalStorageService();
      localStorageService.setToken(token);

      var newUser = User(
        firstName: parsed['user']['firstname'],
        lastName: parsed['user']['lastname'],
        email: parsed['user']['email'],
        genre: parsed['user']['genre'],
        role: parsed['user']['role'],
        birthdate: parsed['user']['birthdate'],
      );
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).setCurrentUser(newUser);
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'X',
            onPressed: () {
              // Code to execute.
            },
          ),
          content: const Text('Informations manquantes ou incorrectes !'),
          duration: const Duration(milliseconds: 1500),
          width: 280.0, // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  Future<bool> getLocalData() async {
    LocalStorageService localStorageService = LocalStorageService();
    String? tkn = await localStorageService.getToken();

    if (tkn != null) {
      setState(() {
        token = tkn;
      });
      return true;
    } else {
      return false;
    }
  }
}
