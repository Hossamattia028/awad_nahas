

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
    debugPrint("generateTokenFromApi: ${response.body}");
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse['output']['sdk_token'];
    }
    return null;
  }

  static Future<List<String>?> generateTokenFromApiApplePay(
      String deviceID) async {
    var response = await post(
      Uri.parse("${ApiUrl.BASE_URL}token_value_ios"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "deviceID":deviceID
      }),
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return [
        decodedResponse['output']['token'],
        decodedResponse['output']['signature'],
      ];
    }
    return null;
  }


  static Future sendApiApplePay(var data) async {
    var response = await post(
      Uri.parse("https://sbpaymentservices.payfort.com/FortAPI/paymentApi"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    debugPrint("res: ${response.body.toString()}");
    // var decodedResponse = jsonDecode(response.body);
  }
}
