import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Page')),
      body: Center(child: Text('This is the Payment Page')),
    );
  }
}
