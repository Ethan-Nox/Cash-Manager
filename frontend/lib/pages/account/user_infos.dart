import 'dart:convert';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserInfosPage extends StatefulWidget {
  const UserInfosPage({super.key});

  @override
  State<UserInfosPage> createState() => _UserInfosPageState();
}

class _UserInfosPageState extends State<UserInfosPage> {
  late TextEditingController firstNameController = TextEditingController()
    ..text = Provider.of<UserProvider>(context, listen: false)
        .currentUser!
        .firstName;
  late TextEditingController lastNameController = TextEditingController()
    ..text =
        Provider.of<UserProvider>(context, listen: false).currentUser!.lastName;
  late TextEditingController emailController = TextEditingController()
    ..text =
        Provider.of<UserProvider>(context, listen: false).currentUser!.email;
  late TextEditingController birthdateController =
      TextEditingController() // ignore: prefer_initializing_formals
        ..text = Provider.of<UserProvider>(context, listen: false)
            .currentUser!
            .birthdate;
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController passwordController2 = TextEditingController();
  bool equalPasswords = true;

  bool other = false;
  bool male = false;
  bool female = false;
  String? genderController;

  bool asChanged = false;
  bool pswdChanged = false;
  bool passwordChanged = false;

  void _selDatePicked() {
    asChanged = true;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(1950))
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

  TextButton saveInfos() {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Save Changes"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context, 'Cancel'),
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {saveUserInfos()},
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(10),
        ),
      ),
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes informations'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // or Axis.vertical,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SizedBox(
                width: 300,
                height: 20,
                child: Text(
                  'Identité',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Prénom',
                  ),
                  controller: firstNameController,
                  onChanged: (value) {
                    // print("HAS CHANGED");
                    setState(() {
                      asChanged = true;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              // const SizedBox(
              //   width: 300,
              //   height: 20,
              //   child: Text(
              //     'Last Name',
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Nom',
                  ),
                  controller: lastNameController,
                  onChanged: (value) {
                    // print("HAS CHANGED");
                    setState(() {
                      asChanged = true;
                    });
                  },
                ),
              ),

              //   --------------------------------------------------------------------------------

              // const SizedBox(
              //   width: 300,
              //   child: Text(
              //     'Gender',
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //       Checkbox(
              //         value: male,
              //         onChanged: (bool? value) {
              //           if (male == true) {
              //             print("c'est true");
              //             setState(() {
              //               male = !male;
              //               female = false;
              //               other = false;
              //               genderController = "0";
              //               asChanged = true;
              //             });
              //           } else {
              //             print("c'est false");
              //             setState(() {
              //               male = !male;
              //               asChanged = true;
              //             });
              //           }
              //         },
              //       ),
              //       const SizedBox(
              //         child: Text(
              //           'Male',
              //           style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(width: 40),
              //       Checkbox(
              //         value: female,
              //         onChanged: (bool? value) {
              //           setState(() {
              //             female = value!;
              //             if (female == true) {
              //               setState(() {
              //                 male = false;
              //                 other = false;
              //                 genderController = "1";
              //                 asChanged = true;
              //               });
              //             }
              //           });
              //         },
              //       ),
              //       const SizedBox(
              //         child: Text(
              //           'Female',
              //           style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(width: 40),
              //       Checkbox(
              //         value: other,
              //         onChanged: (bool? value) {
              //           setState(() {
              //             other = value!;
              //             if (other == true) {
              //               setState(() {
              //                 male = false;
              //                 female = false;
              //                 genderController = "2";
              //                 asChanged = true;
              //               });
              //             }
              //           });
              //         },
              //       ),
              //       const SizedBox(
              //         child: Text(
              //           'Other',
              //           style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ])),
              const SizedBox(height: 20),

              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Date de Naissance',
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
                  'Change Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'New Password',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: equalPasswords ? Colors.black : Colors.red,
                    ),
                  ),
                  controller: passwordController,
                  onChanged: (value) {
                    if (value != passwordController2.text) {
                      print("HAS CHANGED + NOT THE SAME");
                      setState(() {
                        asChanged = true;
                        equalPasswords = false;
                      });
                    } else {
                      print("HAS CHANGED + THE SAME");
                      setState(() {
                        asChanged = true;
                        equalPasswords = true;
                        passwordChanged = true;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              SizedBox(
                width: 300,
                child: TextField(
                  obscuringCharacter: "*",
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: equalPasswords ? Colors.black : Colors.red,
                    ),
                  ),
                  controller: passwordController2,
                  onChanged: (value) {
                    if (value != passwordController2.text) {
                      print("HAS CHANGED + NOT THE SAME");
                      setState(() {
                        asChanged = true;
                        equalPasswords = false;
                      });
                    } else {
                      print("HAS CHANGED + THE SAME");
                      setState(() {
                        asChanged = true;
                        equalPasswords = true;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              (asChanged == true && passwordChanged == false)
                  ? saveInfos()
                  : const SizedBox(
                      height: 5,
                    ),
              (asChanged == true && passwordChanged == true)
                  ? saveInfos()
                  : const SizedBox(
                      height: 5,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void saveUserInfos() async {
    var https = dotenv.env['HTTPS'];
    String url = "$https/users/";
    LocalStorageService localStorageService = LocalStorageService();

    // final msg = jsonEncode({
    //   "firstname": firstNameController.text,
    //   "lastname": lastNameController.text,
    //   // "email": emailController.text,
    //   "birthdate": birthdateController.text,
    //   // "genre": 0,
    //   // "role": "0",
    //   "password": passwordController.text
    // });
    late String msg;
    String? tkn = await localStorageService.getToken();

    if (pswdChanged && asChanged) {
      msg = jsonEncode({
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "email": Provider.of<UserProvider>(context, listen: false)
            .currentUser!
            .email,
        "birthdate": birthdateController.text,
        "genre": Provider.of<UserProvider>(context, listen: false)
            .currentUser!
            .genre,
        "role":
            Provider.of<UserProvider>(context, listen: false).currentUser!.role,
        "password": passwordController.text
      });
    } else {
      msg = jsonEncode({
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "email": Provider.of<UserProvider>(context, listen: false)
            .currentUser!
            .email,
        "birthdate": birthdateController.text,
        "genre": Provider.of<UserProvider>(context, listen: false)
            .currentUser!
            .genre,
        "role":
            Provider.of<UserProvider>(context, listen: false).currentUser!.role,
      });
    }

    print(msg);

    try {
      var response = await http.patch(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'token': tkn.toString()
          },
          body: msg);

      print(tkn);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
          ),
        );
        Navigator.pop(context, 'Cancel');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);

    }
  }
}
