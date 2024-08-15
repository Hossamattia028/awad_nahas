import 'dart:convert';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart';

class TabbyController{
  static Future<String?> getTabbyWebView({required String orderID,required String amount}) async {
    var response = await post(
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
        debugPrint(response.body.toString());
        return response.body.toString();
    }
    return null;
  }

  static validRequest(context){
    if(!Util.checkUser())return SnackBarBuilder.showFeedBackMessage(context, translate("toast.login"), DMUtil.getRED(),);
    if(Util.getMobile().trim()=='')return SnackBarBuilder.showFeedBackMessage(context, translate('toast.please_verify_your_phone'), DMUtil.getRED());
    return true;
  }
}