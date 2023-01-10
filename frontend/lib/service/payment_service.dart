import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentService {
  var https = dotenv.env['HTTPS'];

  Future<void> placePayment(data) async {
    String url = "$https/payment";
    print(data);
    try {
      var response = await http.post(Uri.parse(url), body: data);
      print("RESP $response.body");
    } catch (e) {
      print("ERR $e");
    }
  }
}
