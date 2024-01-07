

import 'dart:convert';


import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class PayFortApi {

  static Future<String?> generateTokenFromApi(
      String deviceID) async {
    var response = await post(
      Uri.parse("${ApiUrl.BASE_URL}token_value"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "deviceID":deviceID
      }),
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse['output'].toString();
    }
    return null;
  }

  static Future<String?> generateTokenFromApiApplePay(
      Map<String,dynamic> data) async {
    var response = await post(
      Uri.parse("${ApiUrl.BASE_URL}token_value_ios"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "data":data
      }),
    );
    debugPrint(" ${response.body}");
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse['output']['signature'].toString();
    }
    return null;
  }

  static Future checkTransactionStatus(var data) async {
    var response = await post(
      Uri.parse("https://sbpaymentservices.payfort.com/FortAPI/paymentApi"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    debugPrint("checkTransactionStatus: ${response.body.toString()}");
    return response.body;
    // var decodedResponse = jsonDecode(response.body);
  }


  static Future sendApiApplePay(var data) async {
    var response = await post(
      Uri.parse("https://sbpaymentservices.payfort.com/FortAPI/paymentApi"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    debugPrint("res: ${response.body.toString()}");

    return response.body.toString();
    // var decodedResponse = jsonDecode(response.body);
  }
}
