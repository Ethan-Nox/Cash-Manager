import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HistoriqueWidget extends StatelessWidget {
  final DateTime date;
  final String refPaiement;
  final String title;
  final String description;
  final String price;
  final Function()? onTap;

  const HistoriqueWidget(
      {super.key,
      this.onTap,
      required this.title,
      required this.date,
      required this.refPaiement,
      required this.price,
      required this.description});

  @override
  Widget build(BuildContext context) {
    var https = dotenv.env['HTTPS'];
    String url = "$https/images/";
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);

    return Column(
      children: [
        // Text(
        //   date.toString(),
        //   textAlign: TextAlign.left,
        // ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: const BorderSide(
                  width: 1, // thickness
                  color: Color.fromARGB(255, 221, 221, 221) // color
                  ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(color: Colors.black),
              ), // <-- Text
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "${url}clock-removebg-preview.png",
                  headers: {
                    "accept": "application/json",
                  },
                ),
              ),
              Text(price + " €"),

              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24.0,
                  color: Color.fromARGB(255, 139, 139, 139),
                ),
                tooltip: "Voir plus",
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  getImage() async {
    var https = dotenv.env['HTTPS'];
    String url = "$https/login";

    try {
      var response = await http.get(
        Uri.parse(url + "/images/" + "clock-removebg-preview.png"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // ignore: avoid_print
      // print("Response body: ${response.body}");
      final Map parsed = json.decode(response.body);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
