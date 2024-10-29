import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String carModel;
  final String price;

  PaymentScreen({required this.carModel, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for $carModel'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Proceed to pay ${price} for the $carModel.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
