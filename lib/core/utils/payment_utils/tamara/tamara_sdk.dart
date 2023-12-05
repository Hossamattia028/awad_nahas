
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;


class TamaraSdk{
  static const tamaraApiToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhY2NvdW50SWQiOiJiZjRhYmI5Ni02NDUyLTQ1ZTYtYTAxOC0zMGRhOWUxODQ2YzkiLCJ0eXBlIjoibWVyY2hhbnQiLCJzYWx0IjoiOTBkNDY5MDc0NTlhNDk1ZTg0MzljMDI5ZTE0M2FiODQiLCJpYXQiOjE2NjY3NzU0ODYsImlzcyI6IlRhbWFyYSBQUCJ9.CPPTTsSu6zjCXzg_MtsGHZJMfn4MNzkEelEXosIBDfR8mAIhEQFG3fna_JEz0a9x1Xfk1V4J4U_g9kmE0Vf8-3uFRIYZevNpu7nFllb3LfMztEWHU1Y5A-vuL1U4x7zJMsrDJwprnrXJDr57KZ-uVVmWGcYdbeXbdo8xYA0mSQFNP4MmTRwPZCWutN3m7xaa4DflWvuj56kKBbn6rL-nfMeNbZUoMf41omOR1GI_Pz7jZwO7v9MwSN5oVg-yJqY1bln2KT7bML5B_nR7M6w-qCibbvaEQ5tPtWNT5ZkPt63KqkKE4W_sB_7kD--1jcECZg40h9EaAugtL38nCQn69A";
  static const baseUrl = "https://api.tamara.co";

  static Future<String?> checkOut({required Map<String,dynamic> data,required BuildContext context})async{
    try {
      if(data['shipping_address'] ==null || data['shipping_address']['line1'].toString().trim()=="" && data['billing_address']!=null){
        data['shipping_address'] = data['billing_address'];
      }
      if(data['shipping_address']['last_name']==null||data['shipping_address']['last_name']=="")data['shipping_address']['last_name']=".";
      if(data['billing_address'] ==null || data['billing_address']['line1'].toString().trim()=="" && data['shipping_address']!=null){
        data['billing_address'] = data['shipping_address'];
      }
      if(data['billing_address']['last_name']==null||data['billing_address']['last_name']=="")data['billing_address']['last_name']=".";
      var headers =  {
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var orderData = {
        "order_reference_id": "${DateTime.now().minute}${DateTime.now().millisecond}${DateTime.now().day}${Util.getUserID()}",
        "order_number": "${DateTime.now().minute}${DateTime.now().millisecond}${DateTime.now().day}${Util.getUserID()}",
        "total_amount": {
          "amount": data['total_price'],
          "currency": "SAR"
        },
        "description": "string",
        "country_code": "SA",
        "payment_type": "PAY_BY_INSTALMENTS",
        "instalments": null,
        "locale": "en_US",
        "items": data['items'],
        "consumer": {
          "first_name": Util.getName()==""?"guest":Util.getName(),
          "last_name": Util.getName()==""?"guest":Util.getName(),
          "phone_number": Util.getMobile()==""?"502441695":Util.getMobile(),
          "email": Util.getEmail()==""?"guest@gmail.com":Util.getEmail(),
        },
        "billing_address": data['billing_address'],
        "shipping_address": data['shipping_address'] ,
        if(data['discount']!=null)"discount": data['discount'],
        "tax_amount": {
          "amount": "0.00",
          "currency": "SAR"
        },
        "shipping_amount": {
          "amount": "0.00",
          "currency": "SAR"
        },
        "merchant_url": {
          "success": "${ApiUrl.MAIN_DOMAIN}/checkout/success",
          "failure": "${ApiUrl.MAIN_DOMAIN}/checkout/failure",
          "cancel": "${ApiUrl.MAIN_DOMAIN}/checkout/cancel",
          "notification": "${ApiUrl.MAIN_DOMAIN}/payments/tamarapay"
        },
        "platform": "Magento",
        "is_mobile": true,
        "risk_assessment": {
          "customer_age": 22,
          "customer_dob": "31-01-2000",
          "customer_gender": "Male",
          "customer_nationality": "SA",
          "is_premium_customer": true,
          "is_existing_customer": true,
          "is_guest_user": true,
          "account_creation_date": "31-01-2019",
          "platform_account_creation_date": "string",
          "date_of_first_transaction": "31-01-2019",
          "is_card_on_file": true,
          "is_COD_customer": true,
          "has_delivered_order": true,
          "is_phone_verified": true,
          "is_fraudulent_customer": true,
          "total_ltv": 501.5,
          "total_order_count": 12,
          "order_amount_last3months": 301.5,
          "order_count_last3months": 2,
          "last_order_date": "31-01-2021",
          "last_order_amount": 301.5,
          "reward_program_enrolled": true,
          "reward_program_points": 300
        },
        "expires_in_minutes": 0,
        "additional_data": {
          "delivery_method": "home delivery",
          "pickup_store": "Store A",
          "store_code": "Store code A",
          "vendor_info": [
            {
              "vendor_amount": 0,
              "merchant_settlement_amount": 0,
              "vendor_reference_code": "string"
            }
          ]
        }
      };
      var response = await http.post(Uri.parse("$baseUrl/checkout"),
        body: jsonEncode(orderData),
        headers: headers,
      );
      debugPrint("checkOutRequest: ${response.body}");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return body['checkout_url'];
      } else {
        SnackBarBuilder.showFeedBackMessage(context, jsonDecode(response.body)['errors'][0]['error_code'].toString().replaceAll("null", "error"), DMUtil.getRED());
        return null;
      }
    } catch (e) {
      debugPrint("checkOut: $e");
      return null;
    }
  }

  static Future<bool> captureRequest({required String paymentID,required var data})async{
    try {
      var headers =  {
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var response = await http.post(Uri.parse("$baseUrl/$paymentID/captures"),
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

  static Future<bool> retrievePayment({required String paymentID,})async{
    try {
      var headers =  {
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      var response = await http.get(Uri.parse("$baseUrl/api/v1/payments/$paymentID"),
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
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var response = await http.post(Uri.parse("$baseUrl/api/v1/webhooks"),
        body: jsonEncode({
          'url':'https://royalstarsmed.com/mobile_api/webhook.php',
          'is_test': true,
        }), headers: headers,
      );
      debugPrint("registerWebHook: ${response.body}");
      debugPrint("registerWebHook: ${response.statusCode}");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
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

  static Future<bool> removeWebHook()async{
    try {
      var headers =  {
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var response = await http.delete(Uri.parse("$baseUrl/api/v1/webhooks/{id}"), headers: headers,
      );
      debugPrint("removeWebHook: ${response.request?.url}");
      debugPrint("removeWebHook: ${response.body}");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if(body['status'].toString().toLowerCase()=="ok"){
          return true;
        }else{
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("removeWebHook: $e");
      return false;
    }
  }
}