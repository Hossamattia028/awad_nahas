import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:http/http.dart' as http ;

String webhookID = "";

class Session{
  final TabbySession? session;
  final bool isSuccess;
  const Session({required this.session,required this.isSuccess});
}

class TabbyPayment{

  static setUpPayment(){
    TabbySDK().setup(
      withApiKey: 'pk_test_72a770e5-f1fe-42aa-8037-16951d1739b4', 
      environment: Environment.stage, 
    );
  }


  static Future<bool> captureRequest({required String paymentID,required var data})async{
    try {
      var headers =  {
        "Authorization": "Bearer sk_test_fdd5175f-8002-4116-9a1c-7310e294df9b",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var response = await http.post(Uri.parse("https://api.tabby.ai/api/v1/payments/$paymentID/captures"),
          body: jsonEncode(data),
          headers: headers,
      );
      debugPrint("captureRequest: ${response.body}");
      debugPrint("res: ${response.statusCode}");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if(body['status'].toString().toLowerCase()=="closed"){
          return true;
        }else{
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("captureRequest: $e");
      return false;
    }
  }

  static Future<bool> retrievePayment({required String paymentID,required Payment payment})async{
    try {
      var headers =  {
        "Authorization": "Bearer sk_test_fdd5175f-8002-4116-9a1c-7310e294df9b",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      var response = await http.get(Uri.parse("https://api.tabby.ai/api/v1/payments/$paymentID"),
        headers: headers,
      );
      debugPrint("retrievePayment $paymentID : ${response.body}");
      debugPrint("res: ${response.statusCode}");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        //body['status'].toString().toLowerCase()=="closed"||
        if(body['status'].toString().toLowerCase()=="authorized"){
          return true;
        }else{
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("retrievePayment: $e");
      return false;
    }
  }

  static Future<bool> registerWebHook(String url)async{
    try {
      var headers =  {
        "Authorization": "Bearer sk_test_fdd5175f-8002-4116-9a1c-7310e294df9b",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Merchant-Code": "ae"
      };
      var response = await http.post(Uri.parse("https://api.tabby.ai/api/v1/webhooks"),
        body: jsonEncode({
          'url':'https://royalstarsmed.com/mobile_api/webhook.php',
          'is_test': true,
        }), headers: headers,
      );
      debugPrint("registerWebHook: ${response.body}");
      debugPrint("registerWebHook: ${response.statusCode}");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        webhookID = body['id'];
        if(body['status'].toString().toLowerCase()=="closed"||body['status'].toString().toLowerCase()=="authorized"){
          return true;
        }else{
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("registerWebHook: $e");
      return false;
    }
  }




}
