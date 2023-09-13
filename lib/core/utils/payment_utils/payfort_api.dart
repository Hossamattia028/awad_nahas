

import 'dart:convert';

import 'package:amazon_payfort/amazon_payfort.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/payment_utils/fort_constants.dart';
import 'package:awad_nahas/core/utils/payment_utils/sdk_token_response.dart';

import 'package:http/http.dart';


class PayFortApi {
  PayFortApi._();

  static Future<SdkTokenResponse?> generateSdkToken(
      SdkTokenRequest request) async {
    var response = await post(
      Uri.parse(FortConstants.environment.paymentApi),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.asRequest()),
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return SdkTokenResponse.fromMap(decodedResponse);
    }
    return null;
  }

  static Future<SdkTokenResponse?> openUrl(
      Map<String,dynamic> data) async {
    var response = await post(
      Uri.parse(FortConstants.environment.paymentApi),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
      // 'command' : 'PURCHASE',
      // 'access_code' : data['access_code'],
      // 'merchant_identifier' :  ,
      // 'merchant_reference':  'XYZ9239-yu898',
      // 'language' : 'en',
      // 'signature' : '7cad05f0212ed933c9a5d5dffa31661acf2c827a',
      // 'order_description' : 'iPhone 6-S',
      // 'customer_email' : 'test@payfort.com',
      // 'token_name' :'7288fc8155014c57ad809d8e9574575e'
      }),
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return SdkTokenResponse.fromMap(decodedResponse);
    }
    return null;
  }

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
      return decodedResponse['output'];
    }
    return null;
  }
}
