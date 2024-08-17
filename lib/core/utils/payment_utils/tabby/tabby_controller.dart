import 'dart:convert';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;

class TabbyController{
  static Future<String?> getTabbyWebView({required String orderID,required String amount}) async {
    var response = await http.post(
      Uri.parse("${ApiUrl.BASE_URL}tabby"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "order_id":orderID,
        "amount":amount,
        "customer_email":'otp.success@tabby.ai',//Util.getEmail(),
        "customer_phone":'500000001', //Util.getMobile(),
      }),
    );
    if (response.statusCode == 200) {
        // debugPrint("getTabbyWebView: ${response.body.toString()}");
        return response.body.toString();
    }
    return null;
  }

  static validRequest(context){
    if(Util.getMobile().trim()=='')return SnackBarBuilder.showFeedBackMessage(context, translate('toast.please_verify_your_phone'), DMUtil.getRED());
    return true;
  }

    static Future<double> getTabbyAmountLimit()async{
    try {
      var headers =  {
        "Authorization": "Bearer ",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      var response = await http.get(Uri.parse("/checkout/payment-types?country=sa"),
        headers: headers,
      );
      // debugPrint("getTamaraAmountLimit: ${response.body}");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return double.parse(body[0]['max_limit']['amount'].toString());
      } else {
        return 5000;
      }
    } catch (e) {
      debugPrint("retrievePayment: $e");
      return 5000;
    }
  }
}