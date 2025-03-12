import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('9.99', 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'Smart Loading',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Betaling geslaagd!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Betaling mislukt: $e")));
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer SK_TEST_KEY',  // Vervang met je eigen Stripe-sleutel
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': (double.parse(amount) * 100).toInt().toString(),
          'currency': currency,
          'payment_method_types[]': 'card',
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Betalen")),
      body: Center(
        child: ElevatedButton(
          onPressed: makePayment,
          child: const Text("Betaal €9.99 om te ontgrendelen"),
        ),
      ),
    );
  }
}
