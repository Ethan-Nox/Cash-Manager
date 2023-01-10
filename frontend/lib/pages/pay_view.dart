import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../service/payment_service.dart';

class payView extends StatelessWidget {
  const payView({super.key, this.total});
  final total;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total: $total'),
            SizedBox(height: 30),
            SizedBox(
              width: 500,
              // height: 700,
              child: CardFormField(
                controller: CardFormEditController(),
                style: CardFormStyle(
                  borderRadius: 2,
                  borderColor: Color.fromARGB(255, 211, 0, 0),
                  borderWidth: 2,
                  placeholderColor: Color.fromARGB(255, 211, 0, 0),
                  // backgroundColor: Color.fromARGB(255, 209, 209, 209)
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("test1");
                PaymentService().placePayment({
                  'number': "4242424242424242",
                  'exp_month': 2,
                  'exp_year': 2024,
                  'cvc': '123',
                  'amount': 200
                });
                print("test2");
              },
              child: Text('Payer'),
            )
          ],
        ),
      ),
    );
  }
}
