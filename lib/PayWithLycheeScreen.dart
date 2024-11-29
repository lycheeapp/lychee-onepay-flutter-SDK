import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lychee_payment_sdk_test/SuccesPage.dart';
import 'package:lychee_payment_sdk_test/api/app/app_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class PayWithLycheeScreen extends StatefulWidget {
  final String amount;
  final String storeName;
  final String storeLogo;
  final String secretKey;
  final String apiKey;
  final String deviceUDID;
  const PayWithLycheeScreen(
      {super.key,
      required this.amount,
      required this.storeName,
      required this.storeLogo,
      required this.secretKey,
      required this.deviceUDID,
      required this.apiKey});

  @override
  _PayWithLycheeScreenState createState() => _PayWithLycheeScreenState();
}

class _PayWithLycheeScreenState extends State<PayWithLycheeScreen> {
  final TextEditingController voucherController = TextEditingController();
  bool isVoucherValid = true;
  bool isTyping = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    voucherController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {
      isTyping = voucherController.text.isNotEmpty;
    });
  }

  Future<void> _payNow() async {
    _validateVoucher();
    if (isVoucherValid) {
      Response? response = await AppRepo.instance().onePayPurchases(
        voucherController.text,
        widget.amount,
        widget.deviceUDID,
        widget.secretKey,
        widget.apiKey,
      );

      // print(response?.data);
      // print(response?.statusCode);
      // print(response?.data['error']);

      if (response?.statusCode != 200) {
        setState(() {
          if (response?.data['status'] == "804") {
            errorText = "Please enter valid code:";
          } else if (response?.data['status'] == "803") {
            errorText = "Voucher must match the payment amount";
          } else {
            errorText = response?.data['error'] ?? response?.data['message'];
          }
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccessScreen(
              amount: double.parse(widget.amount),
            ),
          ),
        );

        isVoucherValid = true;
        isTyping = false;
        errorText = "";
        voucherController.clear();
        //go to page
      }
    }
  }

  void _validateVoucher() async {
    String text = voucherController.text;
    if (text.isEmpty) {
      setState(() {
        errorText = null;
      });
    } else if (text.length > 6) {
      setState(() {
        errorText = 'Enter a valid code';
      });
    } else if (text.length == 6) {
      setState(() {
        errorText = isVoucherValid ? null : 'Invalid voucher code';
      });
    }
  }

  @override
  void dispose() {
    voucherController.removeListener(_updateState);
    voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Text('Pay with Lychee',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40, // The same size as your CircleAvatar's diameter
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            widget.storeLogo, // Replace with a valid image URL
                        placeholder: (context, url) => Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey[
                                  300], // You can also use a loading indicator here
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://s3.us-west-2.amazonaws.com/storetest.lycheeapp.org/laychee.png",
                            )),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.storeName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0, // Text size in logical pixels
                    fontWeight:
                        FontWeight.w600, // Equivalent to a weight of 600
                    color: Color(0xff000000), // Color in ARGB format
                    height: 1.0, // Line height factor, adjust if needed
                  ),
                ),
                const Spacer(),
                Text(
                  'ILS ${widget.amount}',
                  textAlign: TextAlign.right, // Align text to the right
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0, // Font size in logical pixels
                    fontWeight:
                        FontWeight.w600, // Equivalent to a weight of 600
                    color: Color(0xff016fd0), // Color in ARGB format
                    height: 1.0, // Line height as a multiple of font size
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter your onepay code to pay',
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 13.0, // Font size in logical pixels (same as `sp`)
                fontWeight: FontWeight.w500, // Equivalent to a weight of 500
                color: Color(0xff000000), // Hex color with ARGB format
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: voucherController,
              onChanged: (value) {
                setState(() {
                  isTyping = value.isNotEmpty; // Update state when typing
                });
                _validateVoucher();
              },
              decoration: InputDecoration(
                hintText: '9EIMBD', // The placeholder text
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
                      .withOpacity(0.5), // Light gray for placeholder
                ),
                suffixIcon: isTyping
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8.0), // Apply border radius here
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://lycheedev.s3-accelerate.amazonaws.com/business-logos/1723063139417OnePayLogo.jpg",
                              placeholder: (context, url) => Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.grey[
                                    300], // You can also use a loading indicator here
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.grey[
                                    300], // Background color for error widget
                                child: const Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://lycheedev.s3-accelerate.amazonaws.com/business-logos/1723063139417OnePayLogo.jpg",
                                  ),
                                ),
                                Positioned.fill(
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                    child: Container(
                                      color: Colors
                                          .transparent, // Ensures that the blur effect is visible
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: isTyping
                        ? Colors.black
                        : (isVoucherValid ? Colors.grey : Colors.red),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                errorText: errorText,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isTyping
                      ? (voucherController.text.isNotEmpty
                          ? Colors.green
                          : Colors.grey)
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 140, vertical: 16),
                ),
                onPressed: voucherController.text.isNotEmpty
                    ? _payNow
                    : null, // Disable button if no data
                child: const Text(
                  'Pay now',
                  style: TextStyle(
                    fontFamily: 'SF Pro Text', // Set the font family
                    fontSize: 18.0, // Set the text size
                    fontWeight: FontWeight.w500, // Set the text weight
                    color: Colors.white, // Set the text color
                    letterSpacing: 0.0, // Set letter spacing
                  ),
                  textAlign: TextAlign.center, // Center align the text
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () async {
                  var appUrl = "https://www.lycheeapp.org/";
                  try {
                    await launchUrl(Uri.parse(appUrl));
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text(
                  'No voucher? Get a code.',
                  style: TextStyle(
                    fontFamily: 'SF Pro Text', // Set the font family
                    fontSize: 13.0, // Text size in points
                    fontWeight: FontWeight.w400, // Font weight
                    fontStyle: FontStyle.normal, // Text style (normal/italic)
                    color: Color(0xFF000000), // Text color
                    height: 17.0 / 13.0, // Line height relative to text size
                    decoration: TextDecoration.underline,
                    decorationColor:
                        Colors.black, // Optional: Set the underline color
                    decorationThickness:
                        2.0, // Optional: Set the underline thickness
                  ),
                  textAlign: TextAlign.center, // Text alignment
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.security, size: 16, color: Colors.black),
                  SizedBox(width: 4),
                  Text(
                    'Secured By',
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'onepay',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
