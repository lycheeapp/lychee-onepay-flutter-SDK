import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final double amount;

  const PaymentSuccessScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle,
                  size: 100, color: Color(0xFF46ec88)),
              const SizedBox(height: 20.0),
              const Text(
                'Payment Success!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: Theme.of(context).textTheme.headline6,
                  children: [
                    const TextSpan(
                      text: "Your payment of ",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: "ILS ${amount.toStringAsFixed(2)} ",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const TextSpan(
                      text: "has been successfully done.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1ecd64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
