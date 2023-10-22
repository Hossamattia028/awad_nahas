import 'dart:async';
import 'dart:io';
import 'package:awad_nahas/core/utils/payment_utils/payfort_api.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazonpaymentservices/environment_type.dart';
import 'package:flutter_amazonpaymentservices/flutter_amazonpaymentservices.dart';

class PayFortController{

  // final AmazonPayfort _payfort = AmazonPayfort.instance;
  //
  // final NetworkInfo _info = NetworkInfo();
  //
  // Future<void> init() async {
  //   /// Step 1:  Initialize Amazon Payfort
  //   await AmazonPayfort.initialize(
  //     const PayFortOptions(environment: FortConstants.environment),
  //   );
  //
  // }
  //
  // Future<void> paymentWithCreditOrDebitCard({
  //   required SucceededCallback onSucceeded,
  //   required FailedCallback onFailed,
  //   required CancelledCallback onCancelled,
  //   VoidCallback? fn,
  //   required int amount
  // }) async {
  //   try {
  //     var sdkTokenResponse = await _generateSdkToken();
  //
  //     /// Step 4: Processing Payment [Amount multiply with 100] ex. 10 * 100 = 1000 (10 SAR)
  //     FortRequest request = FortRequest(
  //       amount: amount * 100,
  //       customerName: Util.getName() == ""?"customer": Util.getName(),
  //       customerEmail: Util.getEmail() == ""?"customer@gmail.com": Util.getEmail(),
  //       orderDescription: 'New Order',
  //       sdkToken: sdkTokenResponse?.sdkToken ?? '',
  //       merchantReference: const Uuid().v4(),
  //       currency: 'SAR',
  //       customerIp: (await  _info.getWifiIP() ?? ''),
  //     );
  //
  //     _payfort.callPayFort(
  //       request: request,
  //       callBack: PayFortResultCallback(
  //         onSucceeded: onSucceeded,
  //         onFailed: onFailed,
  //         onCancelled: onCancelled,
  //       ),
  //     );
  //   } catch (e) {
  //     onFailed(e.toString());
  //     if(fn!=null)fn;
  //   }
  // }

  // "sdk_token": data?.first.toString(),
  // "access_code": "7nelylVINMWX9iFt9rH5",
  // "merchant_identifier":"3b2f30d0",
  // var sign = "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\/JJxE+T5O8n5sT2KGw\/orv9LkswDwYDVR0TAQH\/BAUwAwEB\/zAfBgNVHSMEGDAWgBS7sN6hWDOImqSKmd6+veuv2sskqzA3BgNVHR8EMDAuMCygKqAohiZodHRwOi8vY3JsLmFwcGxlLmNvbS9hcHBsZXJvb3RjYWczLmNybDAOBgNVHQ8BAf8EBAMCAQYwEAYKKoZIhvdjZAYCDgQCBQAwCgYIKoZIzj0EAwIDZwAwZAIwOs9yg1EWmbGG+zXDVspiv\/QX7dkPdU2ijr7xnIFeQreJ+Jj3m1mfmNVBDY+d6cL+AjAyLdVEIbCjBXdsXfM4O5Bn\/Rd8LCFtlk\/GcmmCEm9U+Hp9G5nLmwmJIWEGmQ8Jkh0AADGCAYgwggGEAgEBMIGGMHoxLjAsBgNVBAMMJUFwcGxlIEFwcGxpY2F0aW9uIEludGVncmF0aW9uIENBIC0gRzMxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUwIITDBBSVGdVDYwCwYJYIZIAWUDBAIBoIGTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAxMDEyMjIzN1owKAYJKoZIhvcNAQk0MRswGTALBglghkgBZQMEAgGhCgYIKoZIzj0EAwIwLwYJKoZIhvcNAQkEMSIEIL5r1aEYKazW4maq65J7CLaX2xBCVXQo4N787dtDOjiEMAoGCCqGSM49BAMCBEcwRQIgRDSyw3zYUMeN5dstor5gkGri7+TctNQ7popHeXrthBcCIQDlnhAUMjGMAL9r7pf0QmxyzRiLpG+dgSd14gwqaOqmaQAAAAAAAA==";

  Future<String> flutterAmazonApplePay({required int amount,required dynamic appleData})async{
    String? id = await FlutterAmazonpaymentservices.getUDID;
    List<String>? data = await PayFortApi.generateTokenFromApiApplePay(id.toString());
    try {
      var requestParam = {
        "digital_wallet":"APPLE_PAY",
        "command":"AUTHORIZATION",
        "merchant_reference": data?.first.toString(),
        "access_code":"7nelylVINMWX9iFt9rH5",
        "merchant_identifier":"3b2f30d0",
        "amount":"100",
        "currency":"SAR",
        "language":"en",
        "customer_email":"test@merchantdomain.com",
        "apple_data":"abcdefgh1234567KEuM/lC6IW7KGO7ydRs95KmLyQC58K4griC/mnAtAYXM/abcdefgh12345678xnEVGMroqTQj/==",
        "apple_signature":"abcdefgh12345678AACggDCCA+abcdefgh12345678IVd+abcdefgh12345678B+g+abcdefgh12345678AO8T9hfo/NooRtvK+Sd48AiEAyAGWQH4jbioivj7Y/abcdefgh12345678AA==",
        "apple_header":{
          "apple_transactionId":"abcdefgh12345678",
          "apple_ephemeralPublicKey":"abcdefgh123456784t3guu+mX+abcdefgh12345678/J4kDgFLnwQ==",
          "apple_publicKeyHash":"AAbbCC+abcdefgh12345678Pbo=="
        },
        "apple_paymentMethod":{
          "apple_displayName":"Visa 000",
          "apple_network":"Visa",
          "apple_type":"debit"
        },
        "signature": data?.last.toString(),
      };
      await PayFortApi.sendApiApplePay(requestParam);
      return "re";
    } on PlatformException catch (e)
    {
      debugPrint("Error ${e.message} details:${e.details}");
      return e.toString();
    }
  }


  Future<bool> flutterAmazon({required int amount})async{
    String? id = await FlutterAmazonpaymentservices.getUDID;
    var token = await PayFortApi.generateTokenFromApi(id.toString());
    var amountVal = Platform.isIOS ? (amount * 100).toString() : amount * 100;
    var requestParam = {
      "amount": amountVal ,
      "command": "AUTHORIZATION",
      "currency": "SAR",
      "customer_email": Util.getEmail(),
      "language": "en",
      "merchant_reference": token,//should be unique
      "sdk_token": token,
    };
    try {
      var result = await FlutterAmazonpaymentservices.normalPay(requestParam, EnvironmentType.sandbox,).onError((error, stackTrace) {
        debugPrint(error.toString());
        throw "error";
      }).catchError((va){
        debugPrint(va.toString());
        return va;
      }).whenComplete(() => debugPrint("comp"));
      debugPrint("res $result");
      // var decodedData = jsonDecode(result.toString());
      if(result['response_code'].toString().trim()=="02000" && result['response_message'].toString().toLowerCase()=="success"){
        return true;
      }else{
        return false;
      }
    } on PlatformException catch (e)
    {
      debugPrint("Error ${e.message} details:${e.details}");
      return false;
    }
  }


  // Future<void> paymentWithApplePay({
  //   required SucceededCallback onSucceeded,
  //   required FailedCallback onFailed,
  //   required int amount
  // }) async {
  //   try {
  //      var sdkTokenResponse = await _generateSdkToken(isApplePay: true);
  //     /// Step 4: Processing Payment [Don't multiply with 100]
  //     FortRequest request = FortRequest(
  //       amount: amount,
  //       // customerName: Util.getName() == ""?"customer": Util.getName(),
  //       customerName: "nameTest",
  //       customerEmail: Util.getEmail() == ""?"customer@gmail.com": Util.getEmail(),
  //       orderDescription: 'New Order',
  //       sdkToken: sdkTokenResponse?.sdkToken ?? '',
  //       merchantReference: const Uuid().v4(),
  //       currency: 'SAR',
  //       customerIp: (await _info.getWifiIP() ?? ''),
  //     );
  //
  //     _payfort.callPayFortForApplePay(
  //       request: request,
  //       countryIsoCode: 'SA',
  //       applePayMerchantId: FortConstants.applePayMerchantId,
  //       callback: ApplePayResultCallback(
  //         onSucceeded: onSucceeded,
  //         onFailed: onFailed,
  //       ),
  //     ).onError((error, stackTrace) => debugPrint("$error")).catchError((va){
  //       debugPrint(va.toString());
  //       return va;
  //     });
  //   } catch (e) {
  //     debugPrint("paymentWithApplePay: $e");
  //     onFailed(e.toString());
  //   }
  // }
  //
  // Future<SdkTokenResponse?> _generateSdkToken({bool isApplePay = false}) async {
  //   try {
  //     var accessCode = isApplePay
  //         ? FortConstants.applePayAccessCode
  //         : FortConstants.accessCode;
  //     var shaRequestPhrase = isApplePay
  //         ? FortConstants.applePayShaRequestPhrase
  //         : FortConstants.shaRequestPhrase;
  //     String? deviceId = await _payfort.getDeviceId();
  //
  //     /// Step 2:  Generate the Signature
  //     SdkTokenRequest tokenRequest = SdkTokenRequest(
  //       accessCode: accessCode,
  //       deviceId: deviceId ?? '',
  //       merchantIdentifier: FortConstants.merchantIdentifier,
  //     );
  //     String? signature = await _payfort.generateSignature(
  //       shaType: FortConstants.shaType,
  //       concatenatedString: tokenRequest.toConcatenatedString(shaRequestPhrase),
  //     );
  //
  //     tokenRequest = tokenRequest.copyWith(signature: signature);
  //     /// Step 3: Generate the SDK Token
  //     return await PayFortApi.generateSdkToken(tokenRequest);
  //   } finally {
  //
  //   }
  // }

}