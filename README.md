# Lychee Payment SDK Documentation

### Overview
The Payment SDK allows you to easily integrate payment functionality into your Flutter application using Lychee Payment APIs. This SDK provides a seamless way to process payments and manage transactions with Lychee.

### Installation
1. Add the following dependencies to your `pubspec.yaml` file:
    ```yaml
    dependencies:
      flutter:
        sdk: flutter
    crypto: ^3.0.0
    dio: ^5.7.0
    cached_network_image: ^3.2.3
    url_launcher: ^6.0.4
    ```

2. Import the necessary files into your Dart file:
    ```dart
    import 'package:lychee_payment_sdk_test/payment_sdk.dart';
    ```

### Usage
You can use the Payment SDK to open a payment screen with the following command:

```dart
PaymentSDK.PayWithLychee(
  context: context,
  amount: '200', // Amount to be paid
  storeName: 'Your Store', // Name of the store
  storeLogo: 'https://yourlogo.url', // Store logo URL
  secretKey: 'your-secret-key', // Secret key for signature
  apiKey: 'your-api-key', // API key
  deviceUDID: 'your-device-udid', // Device unique ID
);
```

### Methods

#### `PayWithLychee`
This method navigates to the payment page and opens the payment screen.

##### Parameters:
- **context**: The `BuildContext` of the screen.
- **amount**: The total amount to be paid as a `String`.
- **storeName**: Name of the store as a `String`.
- **storeLogo**: URL of the store's logo as a `String`.
- **secretKey**: The secret key used to generate the signature.
- **apiKey**: The API key to authorize the payment.
- **deviceUDID**: The unique identifier of the device making the request.

##### Example:
```dart
PaymentSDK.PayWithLychee(
  context: context,
  amount: '500',
  storeName: 'Your Store Name',
  storeLogo: 'https://example.com/logo.png',
  secretKey: 'your-secret-key',
  apiKey: 'your-api-key',
  deviceUDID: 'device-udid'
);
```

### Error Handling
When performing a payment, the SDK will automatically handle errors and display them in the UI. If a payment fails, an error message will be shown, and the user will be prompted to retry or correct the input.


### Payment Success
Once the payment is successfully completed, the user will be navigated to the success screen (`PaymentSuccessScreen`) showing the amount that was paid. You can customize this screen to display additional information such as the transaction ID.

### Screens in SDK
1. **PayWithLycheeScreen**: The main screen where users enter their payment details and voucher codes.
2. **PaymentSuccessScreen**: Displays when a payment is successful.

### Example Application

```dart
import 'package:flutter/material.dart';
import 'package:lychee_payment_sdk_test/payment_sdk.dart';

void main() => runApp(const PaymentApp());

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lychee Payment SDK Demo',
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
        title: const Text('Lychee Payment SDK Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            PaymentSDK.PayWithLychee(
                context: context,
                amount: '200', //total amount
                storeName: 'Mart.ps', //store name
                storeLogo:
                    'https://s3.us-west-2.amazonaws.com/storetest.lycheeapp.org/laychee.png', //store logo
                secretKey: 'your-secret-key',
                apiKey: 'your-api-key',
                deviceUDID: '12345');
          },
          child: const Text('Continue Payment'),
        ),
      ),
    );
  }
}
```

---