
import 'dart:convert';

import 'package:amazon_payfort/amazon_payfort.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/fort_constants.dart';
import 'package:awad_nahas/core/utils/payment_utils/payfort_api.dart';
import 'package:awad_nahas/core/utils/payment_utils/sdk_token_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazonpaymentservices/environment_type.dart';
import 'package:flutter_amazonpaymentservices/flutter_amazonpaymentservices.dart';
import 'package:flutter_payfort_sdk/enums/enums.dart';
import 'package:flutter_payfort_sdk/flutter_payfort_sdk.dart';
import 'package:flutter_payfort_sdk/models/create_token_request.dart';
import 'package:flutter_payfort_sdk/models/create_token_response.dart';
import 'package:flutter_payfort_sdk/models/payment_activity_args.dart';
import 'package:flutter_payfort_sdk/models/payment_activity_result.dart';
import 'package:network_info_plus/network_info_plus.dart';
// import 'package:payfort_plugin/payfort_plugin.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class PayFortController{

  final AmazonPayfort _payfort = AmazonPayfort.instance;

  final NetworkInfo _info = NetworkInfo();

  Future<void> init() async {
    /// Step 1:  Initialize Amazon Payfort
    await AmazonPayfort.initialize(
      const PayFortOptions(environment: FortConstants.environment),
    );

  }


  Future<bool> payWithNativeActivity()async{
    var languageCode = "en";
    try{
      var sdkTokenResponse = await _generateSdkToken();

      PaymentActivityArgs paymentActivityArgs = PaymentActivityArgs(
          environment: ENVIRONMENT.test,
          command: COMMAND.purchase,
          customerEmail: "test@gmail.com",
          languageCode: languageCode,
          currency: "SAR",
          amount:"400",
          sdkToken: sdkTokenResponse?.sdkToken ?? '',
          merchantReference: const Uuid().v4(),
          loadingMessage:languageCode);

      PaymentActivityResult? paymentActivityResult = await FlutterPayfortSdk.goToPaymentActivity(paymentActivityArgs);
      if (paymentActivityResult != null &&
          paymentActivityResult.success != null &&
          paymentActivityResult.success == true) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      return false;
    }
  }


  Future<void> paymentWithCreditOrDebitCard({
    VoidCallback? fn,
    required SucceededCallback onSucceeded,
    required FailedCallback onFailed,
    required CancelledCallback onCancelled,
    required int amount
  }) async {
    try {
      var sdkTokenResponse = await _generateSdkToken();
      // var requestParam = {
      //   "amount": 100,
      //   "command": "AUTHORIZATION",
      //   "currency": "USD",
      //   "customer_email": "test@gmail.com",
      //   "language": "en",
      //   "merchant_reference": const Uuid().v4(),
      //   "sdk_token":  sdkTokenResponse?.sdkToken ?? '',
      //   'order_description' : 'iPhone 6-S',
      // };
      // PayfortPlugin.getID.then((value) => {
      //   //use this call to get device id and send it to server
      //   PayfortPlugin.performPaymentRequest(
      //       const Uuid().v4(),
      //       sdkTokenResponse?.sdkToken ?? '',
      //       'ahmed',
      //       'en',
      //       'user@mail.com',
      //       '100',
      //       'PURCHASE',
      //       'SAR',
      //       '0' //zero for test mode and one for production
      //   )
      //       .then((value) => {
      //     print('card number is ${value!['card_number']}')
      //   })
      // });


      // var requestParam = {
      //   "amount": 100,
      //   "command": "AUTHORIZATION",
      //   "currency": "USD",
      //   "customer_email": "test@gmail.com",
      //   "language": "en",
      //   "merchant_reference": const Uuid().v4(),
      //   "sdk_token":  sdkTokenResponse?.sdkToken ?? '',
      // };
      // try{
      // var result = await FlutterAmazonpaymentservices.normalPay(requestParam, EnvironmentType.production, isShowResponsePage: true);
      //   print(result.entries.toString());
      // } on PlatformException catch (e)
      // {
      //   print("Error ${e.message} details:${e.details}"); return;
      // }
      /// Step 4: Processing Payment [Amount multiply with 100] ex. 10 * 100 = 1000 (10 SAR)
      FortRequest request = FortRequest(
        amount: amount * 100,
        customerName: 'Test Customer',
        customerEmail: 'test@customer.com',
        orderDescription: 'Test Order',
        sdkToken: sdkTokenResponse?.sdkToken ?? '',
        merchantReference: const Uuid().v4(),
        currency: 'SAR',
        customerIp: (await  _info.getWifiIP() ?? ''),
      );

      _payfort.callPayFort(
        request: request,
        callBack: PayFortResultCallback(
          onSucceeded: onSucceeded,
          onFailed: onFailed,
          onCancelled: onCancelled,
        ),
      );
    } catch (e) {
      onFailed(e.toString());
      if(fn!=null)fn;
    }
  }
  _openActivity() async {
    var languageCode = "en";
    try {
      String? deviceId = await FlutterPayfortSdk.getDeviceId();

      // CreateTokenRequest createTokenRequest = CreateTokenRequest(
      //     serviceCommand: "SDK_TOKEN",
      //     accessCode: FortConstants.accessCode,
      //     merchantIdentifier: FortConstants.merchantIdentifier,
      //     language: languageCode,
      //     deviceId: deviceId);
      // print(createTokenRequest.toJson());
      // ///FortAPI/paymentApi
      // http.Response result = await http.post(
      //     Uri.parse("https://sbpaymentservices.payfort.com/FortAPI/paymentApi"),
      //     headers: {
      //       "Content-Type": "application/json; charset=utf8"
      //     },
      //     body: createTokenRequest.toJson());
      //
      // print(result.body.toString());
      // CreateTokenResponse tokenRes =
      // CreateTokenResponse.fromJson(jsonDecode(result.body));
      //
      // if (tokenRes.success != null && tokenRes.success == true) {
      //4. create object paymentActivityArgs which holds all required arguments for payfort sdk and payment activity
      var sdkTokenResponse = await _generateSdkToken();

      PaymentActivityArgs paymentActivityArgs = PaymentActivityArgs(
          environment: ENVIRONMENT.test,
          command: COMMAND.purchase,
          customerEmail: "test@gmail.com",
          languageCode: languageCode,
          currency: "SAR",
          amount:"400",
          sdkToken: sdkTokenResponse?.sdkToken ?? '',
          merchantReference: "23434324-4234324-$deviceId" ,
          loadingMessage:languageCode);
      //4. open native activity and send paymentActivityArgs
      PaymentActivityResult? paymentActivityResult =
      await FlutterPayfortSdk.goToPaymentActivity(paymentActivityArgs);

      if (paymentActivityResult != null &&
          paymentActivityResult.success != null &&
          paymentActivityResult.success == true) {

        print("${paymentActivityResult.responseMessage}");
        print("${paymentActivityResult.success}");
      } else {
        print("${paymentActivityResult?.responseMessage}");
        print("${paymentActivityResult?.success}");
      }
      // } else {
      //
      // }

    } catch (err) {

    }
  }

  Future<void> paymentWithApplePay({
    required SucceededCallback onSucceeded,
    required FailedCallback onFailed,
  }) async {
    try {
       var sdkTokenResponse = await _generateSdkToken(isApplePay: true);
      /// Step 4: Processing Payment [Don't multiply with 100]
      FortRequest request = FortRequest(
        amount: 1000,
        customerName: 'Test Customer',
        customerEmail: 'test@customer.com',
        orderDescription: 'Test Order',
        sdkToken: sdkTokenResponse?.sdkToken ?? '',
        merchantReference: const Uuid().v4(),
        currency: 'SAR',
        customerIp: (await _info.getWifiIP() ?? ''),
      );

      _payfort.callPayFortForApplePay(
        request: request,
        countryIsoCode: 'SA',
        applePayMerchantId: FortConstants.applePayMerchantId,
        callback: ApplePayResultCallback(
          onSucceeded: onSucceeded,
          onFailed: onFailed,
        ),
      );
    } catch (e) {
      onFailed(e.toString());
    }
  }




  Future<SdkTokenResponse?> _generateSdkToken({bool isApplePay = false}) async {
    try {
      var accessCode = isApplePay
          ? FortConstants.applePayAccessCode
          : FortConstants.accessCode;
      var shaRequestPhrase = isApplePay
          ? FortConstants.applePayShaRequestPhrase
          : FortConstants.shaRequestPhrase;
      String? deviceId = await _payfort.getDeviceId();

      /// Step 2:  Generate the Signature
      SdkTokenRequest tokenRequest = SdkTokenRequest(
        accessCode: accessCode,
        deviceId: deviceId ?? '',
        merchantIdentifier: FortConstants.merchantIdentifier,
      );

      String? signature = await _payfort.generateSignature(
        shaType: FortConstants.shaType,
        concatenatedString: tokenRequest.toConcatenatedString(shaRequestPhrase),
      );

      tokenRequest = tokenRequest.copyWith(signature: signature);

      /// Step 3: Generate the SDK Token
      return await PayFortApi.generateSdkToken(tokenRequest);
    } finally {

    }
  }

}