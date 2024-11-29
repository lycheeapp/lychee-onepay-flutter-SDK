import 'package:flutter/material.dart';
import 'package:lychee_payment_sdk_test/PayWithLycheeScreen.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class PaymentSDK {
  static Future<void> PayWithLychee(
      {required BuildContext context,
      required String amount,
      required String storeName,
      required String storeLogo,
      required String secretKey,
      required String apiKey,
      required String deviceUDID}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PayWithLycheeScreen(
          amount: amount,
          storeName: storeName,
          storeLogo: storeLogo,
          secretKey: secretKey,
          apiKey: apiKey,
          deviceUDID: deviceUDID,
        ),
      ),
    );
  }

  static String? createSignature(String payload, String secretKey) {
    try {
      // Concatenate secretKey and payload
      final data = secretKey + payload;

      // Compute the SHA-256 hash
      final bytes = utf8.encode(data);
      final digest = sha256.convert(bytes);

      // Convert to Base64
      final hmacBase64 = base64Encode(digest.bytes);
      return hmacBase64;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
