import 'dart:async';
import 'dart:io';
import 'package:awad_nahas/core/utils/payment_utils/payfort_api.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazonpaymentservices/environment_type.dart';
import 'package:flutter_amazonpaymentservices/flutter_amazonpaymentservices.dart';

class PayFortController{

  Future<String> flutterAmazonApplePay({required int amount,required dynamic appleData})async{
    String? id = await FlutterAmazonpaymentservices.getUDID;
    List<String>? data = await PayFortApi.generateTokenFromApiApplePay(id.toString());
    try {
      var requestParam = {
        "digital_wallet":"APPLE_PAY",
        "command":"PURCHASE",
        "merchant_reference": data?.first.toString(),
        "sdk_token": data?.first.toString(),
        "amount":"1000",
        "currency":"SAR",
        "language":"en",
        "customer_email":"test@merchantdomain.com",
        "phone_number":"966533021223",
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
        "apple_version": "",
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
      var result = await FlutterAmazonpaymentservices.normalPay(requestParam, EnvironmentType.production,);
      debugPrint("res $result");
      if(result['response_code'].toString().trim()=="02000" || result['response_message'].toString().toLowerCase()=="success"){
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


}