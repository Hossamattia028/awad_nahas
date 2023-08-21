import 'package:amazon_payfort/amazon_payfort.dart';

class FortConstants {
  FortConstants._();

  static const FortEnvironment environment = FortEnvironment.test;

  // static const String merchantIdentifier = '< Enter your Merchant Identifier >';

  // // For Debit/Credit Card
  // static const String accessCode = '< Enter your Access Code >';
  // static const String shaType = '< Enter your SHA Type >';
  // static const String shaRequestPhrase = '< Enter your SHA Request Phrase >';

  // // For Apple Pay
  // static const String applePayAccessCode = '< Enter your Access Code >';
  // static const String applePayShaType = '< Enter your SHA Type >';
  // static const String applePayShaRequestPhrase =
  //     '< Enter your SHA Request Phrase >';

  // static const String applePayMerchantId =
  //     '< Enter your Apple Pay Merchant Id >';

  static const String merchantIdentifier = '3b2f30d0';

  // For Debit/Credit Card
  static const String accessCode = 'i8dvi70pglPSPwXX21Au';
  static const String shaType = 'SHA-256';
  static const String shaRequestPhrase = "\$2y\$10\$jrdMr/0E5";

  // For Apple Pay
  static const String applePayAccessCode = '7nelylVINMWX9iFt9rH5';
  static const String applePayShaType = 'SHA-256';
  static const String applePayShaRequestPhrase = '50XSbUyH95XFTXLFrbhdrY](';

  static const String applePayMerchantId = 'merchant.d.dooskarting.com';
}
