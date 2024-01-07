import 'dart:async';
import 'dart:io';
import 'package:awad_nahas/core/utils/payment_utils/payfort_api.dart';
import 'package:awad_nahas/core/utils/payment_utils/payfort_response.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazonpaymentservices/environment_type.dart';
import 'package:flutter_amazonpaymentservices/flutter_amazonpaymentservices.dart';

class PayFortController{

  Future<String> flutterAmazonApplePay({required int amount,required  Map<String,dynamic> appleData})async{
    try {
      String? id = await FlutterAmazonpaymentservices.getUDID;
      var merchantRef = await PayFortApi.generateTokenFromApi(id.toString());
      String appleTransactionId =  appleData['token']['header']['transactionId'].toString();
      String appleEphemeralPublicKey =  appleData['token']['header']['ephemeralPublicKey'].toString();
      String applePublicKeyHash =  appleData['token']['header']['publicKeyHash'].toString();
      String appleDisplayName = appleData['paymentMethod']['displayName'].toString();
      String appleNetwork = appleData['paymentMethod']['network'].toString();
      String appleType =  appleData['paymentMethod']['type'].toString();
      var data = {
        "access_code": "7nelylVINMWX9iFt9rH5",
        "amount":"10",
        "apple_data": appleData['token']['data'],
        "apple_header":{
          "apple_transactionId": appleTransactionId,
          "apple_ephemeralPublicKey": appleEphemeralPublicKey,
          "apple_publicKeyHash": applePublicKeyHash
        },
        "apple_paymentMethod":{
          "apple_displayName": appleDisplayName,
          "apple_network": appleNetwork,
          "apple_type": appleType // no numeric : credit
        },
        "apple_signature": appleData['token']['signature'],
        "command": "PURCHASE",
        "currency":"SAR",
        "customer_email":"test@merchantdomain.com",
        "customer_name": "test",
        "digital_wallet": "APPLE_PAY",
        "language": "en",
        "merchant_identifier": "3b2f30d0",
        "merchant_reference": merchantRef
      };
      // // "customer_ip":"192.0.0.0",
      // // "apple_version": "",
      String signature = 'access_code=${data['access_code']}amount=${data['amount']}apple_data=${data['apple_data']}apple_header={apple_transactionId=$appleTransactionId, apple_ephemeralPublicKey=$appleEphemeralPublicKey, apple_publicKeyHash=$applePublicKeyHash}apple_paymentMethod={apple_displayName=$appleDisplayName, apple_network=$appleNetwork, apple_type=$appleType}apple_signature=${data['apple_signature']}command=${data['command']}currency=${data['currency']}customer_email=${data['customer_email']}customer_name=${data['customer_name']}digital_wallet=${data['digital_wallet']}language=${data['language']}merchant_identifier=${data['merchant_identifier']}merchant_reference=${data['merchant_reference']}';
      /// will replace with production keys
      data['signature'] = '50XSbUyH95XFTXLFrbhdrY](${signature.toString().trim()}50XSbUyH95XFTXLFrbhdrY](';
      var sign = await PayFortApi.generateTokenFromApiApplePay({'d':data['signature']});
      data['signature'] = sign.toString();
      final res = await PayFortApi.sendApiApplePay(data);
      return res;
    } on PlatformException catch (e)
    {
      debugPrint("Error ${e.message} details:${e.details}");
      return e.toString();
    }
  }


  Future<PayfortResponse> flutterAmazon({required int amount})async{
    String? id = await FlutterAmazonpaymentservices.getUDID;
    var sdkToken = await PayFortApi.generateTokenFromApi(id.toString());
    var amountVal = Platform.isIOS ? (amount * 100).toString() : amount * 100;
    var requestParam = {
      "amount": amountVal ,
      "command": "PURCHASE",
      "currency": "SAR",
      "customer_email": Util.getEmail(),
      // "customer_ip": customerIp,
      "language": "en",
      "merchant_reference": sdkToken,//should be unique
      "sdk_token": sdkToken,
    };
    try {
      var result = await FlutterAmazonpaymentservices.normalPay(requestParam, EnvironmentType.sandbox,);
      // debugPrint("res $result");
      if(result['response_code'].toString().trim()=="02000" || result['response_message'].toString().toLowerCase()=="success"){
        return PayfortResponse(res: result.cast<String, dynamic>(), check: true);
      }else{
        return PayfortResponse(res: result.cast<String, dynamic>(), check: false);
      }
    } on PlatformException catch (e)
    {
      debugPrint("Error ${e.message} details:${e.details}");
      return PayfortResponse(res: null, check: false);
    }
  }


}