import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/caches/sharedPreferences.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/home_view.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

getDataLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('lastToken');
  String? user = prefs.getString('lastUser');
  String? psswd = prefs.getString('lastPassword');
  print(token);
  print(user);
  print(psswd);
  // if (token != null) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const HomeView()));
  // }
}

setDataLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('lastUser', 'abcd');
  prefs.setString('lastPassword', 'abcd');
  prefs.setString('lastToken', 'abcd');
}

setFakeDataLocalStorage(user, login) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('lastUser', user);
  prefs.setString('lastPassword', login);
}

// Future<List> getFakeDataLocalStorage(context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? user = prefs.getString('lastUser');
//   String? psswd = prefs.getString('lastPassword');
//   List<String?> finalR = [];

//   if (user != null && psswd != null) {
//     finalR = [user, psswd];
//     Provider.of<UserProvider>(context, listen: false).setOldUser(user);
//     Provider.of<UserProvider>(context, listen: false).setOldPassword(psswd);
//   } else {
//     finalR = [""];
//   }

//   // return finalR;
//   return [user, psswd];
// }

getFakeDataLocalStorage(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('lastUser');
  String? psswd = prefs.getString('lastPassword');
  // List<String?> finalR = [];

  if (user != null && psswd != null) {
    // finalR = [user, psswd];
    Provider.of<UserProvider>(context, listen: false).setOldUser(user);
    Provider.of<UserProvider>(context, listen: false).setOldPassword(psswd);
    return true;
  } else {
    // finalR = [""];
    return false;
  }

  // return finalR;
  // return [user, psswd];
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
