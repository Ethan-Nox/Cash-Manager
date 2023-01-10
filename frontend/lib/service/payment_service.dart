import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentService {
  var https = dotenv.env['HTTPS'];

  Future<http.Response> placePayment(
      {required String number,
      required int exp_month,
      required int exp_year,
      required String cvc , required int amount }) async {
    final Map<String, dynamic> data = {
      "number": number,
      "exp_month": exp_month,
      "exp_year": exp_year,
      "cvc": cvc,
      "amount": amount
    };
    final http.Response response = await http.post(
      Uri.parse('$https/pay'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return response;
  }
}
