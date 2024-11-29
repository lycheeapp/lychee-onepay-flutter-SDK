// import 'package:flutter_test/flutter_test.dart';
// import 'package:payment_sdk/payment_sdk.dart';
// import 'package:payment_sdk/payment_sdk_platform_interface.dart';
// import 'package:payment_sdk/payment_sdk_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockPaymentSdkPlatform
//     with MockPlatformInterfaceMixin
//     implements PaymentSdkPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final PaymentSdkPlatform initialPlatform = PaymentSdkPlatform.instance;
//
//   test('$MethodChannelPaymentSdk is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelPaymentSdk>());
//   });
//
//   test('getPlatformVersion', () async {
//     PaymentSdk paymentSdkPlugin = PaymentSdk();
//     MockPaymentSdkPlatform fakePlatform = MockPaymentSdkPlatform();
//     PaymentSdkPlatform.instance = fakePlatform;
//
//     expect(await paymentSdkPlugin.getPlatformVersion(), '42');
//   });
// }
