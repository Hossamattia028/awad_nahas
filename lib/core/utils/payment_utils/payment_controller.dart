import 'dart:async';
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


  Future<bool> flutterAmazonApplePay({required int amount,required dynamic appleData})async{
    String? id = await FlutterAmazonpaymentservices.getUDID;
    var token = await PayFortApi.generateTokenFromApiApplePay(id.toString());
    try {
      var requestParam = {
        "amount": amount * 100 ,
        "command": "AUTHORIZATION",
        "currency": "SAR",
        "customer_email": Util.getEmail(),
        "language": "en",
        "merchant_reference": token,
        "sdk_token": token,
        "digital_wallet": "APPLE_PAY",
        "apple_data": appleData['token']['data'],
        "apple_signature": appleData['token']['signature'],
        "apple_header":{
          'apple_transactionId': appleData['token']['header']['ephemeralPublicKey'],
          'apple_ephemeralPublicKey': appleData['token']['header']['publicKeyHash'],
          'apple_publicKeyHash': appleData['token']['header']['transactionId'],
        },
        "apple_paymentMethod":{
          'apple_displayName': appleData['paymentMethod']['displayName'],
          'apple_network': appleData['paymentMethod']['network'],
          'apple_type': appleData['paymentMethod']['type'],
        },
        "signature": appleData['token']['signature'],
      };
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


  Future<bool> flutterAmazon({required int amount})async{
    String? id = await FlutterAmazonpaymentservices.getUDID;
    var token = await PayFortApi.generateTokenFromApi(id.toString());
    var requestParam = {
      "amount": amount * 100 ,
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
  //       amount: amount * 100,
  //       customerName: Util.getName() == ""?"customer": Util.getName(),
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
  //     );
  //   } catch (e) {
  //     debugPrint("paymentWithApplePay: $e");
  //     onFailed(e.toString());
  //   }
  // }
  //
  //
  //
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