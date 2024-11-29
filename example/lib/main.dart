import 'package:flutter/material.dart';
import 'package:lychee_payment_sdk_test/payment_sdk.dart';

void main() => runApp(const PaymentApp());

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Payment SDK Demo',
      home: PaymentHomePage(),
    );
  }
}

class PaymentHomePage extends StatelessWidget {
  const PaymentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment SDK Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            PaymentSDK.PayWithLychee(
                context: context,
                amount: '1.55', //total amount
                storeName: 'Mart.ps', //store name
                storeLogo:
                    'https://s3.us-west-2.amazonaws.com/storetest.lycheeapp.org/laychee.png', //store logo
                secretKey: 'CnL+y/M/3o+3ba1cD3rlgLbtkGwMJwcigPoXvsIvsEg=',
                apiKey: 'eb9fd929-f952-48ce-a817-a21b5997ff91',
                deviceUDID: 'qqqq');
          },
          child: const Text('Open Payment Dialog'),
        ),
      ),
    );
  }
}
