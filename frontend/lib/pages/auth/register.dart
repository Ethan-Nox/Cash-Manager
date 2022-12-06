import 'dart:developer';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/auth/login.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool other = false;
  bool male = false;
  bool female = false;

  String? genderController;

  final textController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdateController = TextEditingController();
  final passwordController = TextEditingController();

  void _selDatePicked() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // formatage de la date YYYY-MM-DD
        birthdateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromARGB(255, 203, 33, 209),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 300,
              child: Text(
                'Register',
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
                      print("Clicked on Register");
                    },
                    child: const Text('Register'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 203, 33, 209),
                      minimumSize: const Size(150, 40),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 203, 33, 209),
                      minimumSize: const Size(150, 40),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              height: 20,
              child: Text(
                'First Name',
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
                  labelText: 'First Name',
                ),
                controller: firstNameController,
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              height: 20,
              child: Text(
                'Last Name',
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
                  labelText: 'Last Name',
                ),
                controller: lastNameController,
              ),
            ),
            const SizedBox(height: 10),
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
              child: Text(
                'Gender',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                value: male,
                onChanged: (bool? value) {
                  setState(() {
                    male = value!;
                    if (male == true) {
                      female = false;
                      other = false;
                      setState(() {
                        genderController = "0";
                      });
                    }
                  });
                },
              ),
              const SizedBox(
                child: Text(
                  'Male',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              Checkbox(
                value: female,
                onChanged: (bool? value) {
                  setState(() {
                    female = value!;
                    if (female == true) {
                      male = false;
                      other = false;
                      setState(() {
                        genderController = "1";
                      });
                    }
                  });
                },
              ),
              const SizedBox(
                child: Text(
                  'Female',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              Checkbox(
                value: other,
                onChanged: (bool? value) {
                  setState(() {
                    other = value!;
                    if (other == true) {
                      male = false;
                      female = false;
                      setState(() {
                        genderController = "2";
                      });
                    }
                  });
                },
              ),
              const SizedBox(
                child: Text(
                  'Other',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ])),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              height: 20,
              child: Text(
                'Birthday',
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
                  labelText: 'Birthday',
                ),
                onTap: _selDatePicked,
                controller: birthdateController,
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
                obscuringCharacter: "*",
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
                  primary: const Color.fromARGB(255, 203, 33, 209),
                  onPrimary: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: registerUser,
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      )),
    );
  }

  registerUser() async {
    var https = dotenv.env['HTTPS'];
    String url = "$https/register";
    final msg = jsonEncode({
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "email": emailController.text,
      "birthdate": birthdateController.text,
      "genre": 0,
      "role": "0",
      "password": passwordController.text
    });
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: msg);

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully'),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
