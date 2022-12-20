import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class FactureWidget extends StatelessWidget {
  final String date;
  final String target;
  const FactureWidget({super.key, required this.target, required this.date});

  @override
  Widget build(BuildContext context) {
    var https = dotenv.env['HTTPS'];
    String url = "$https/images/";
    // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);

    return Scaffold(
      appBar: AppBar(
        title: Text(date),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                "${url}${target}",
                headers: {
                  "accept": "application/json",
                },
              ),
              fit: BoxFit.contain),
        ),
        // child: const Text(
        //   'Image in fullscreen',
        //   style: TextStyle(fontSize: 34, color: Colors.red),
        // ),
      ),
    );
  }
}


 // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     "${url}clock-removebg-preview.png",
              //     headers: {
              //       "accept": "application/json",
              //     },
              //   ),
              // ),