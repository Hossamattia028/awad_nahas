
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/core/utils/sms_api.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;


class TamaraSdk{
  static const tamaraApiToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhY2NvdW50SWQiOiI2ZDlmYmIyYi1jN2M0LTRiOTctOTRkMi01ZTU2MGRiY2M2OGQiLCJ0eXBlIjoibWVyY2hhbnQiLCJzYWx0IjoiNmE4MGE1MzRjZGQ2MmNlZWQ3MGYzMTZlYzIwYzAzMmEiLCJpYXQiOjE2NjYwODUyMjIsImlzcyI6IlRhbWFyYSJ9.LEp04JkR_wd0BOUOOthwpsiU4F-i8LDhGHWCt5dSmS4ieXkP1dWdUQSFZsDS4UTiYUmpqdQRIN5uVJnt6PH76BecPWoYOceT1Q9z6wvFHTev8JoS_IXZ7Op4dcg6YuBnBtD8H5Z3aNVI9TpPX5Ulgq8U6y0Na7RmHBdnYiO-K1cuHoSD8Uobp-h2GZOnyHg1PzsuklIoMIq-YIlLxcx7AehQ4jv7OWbj632rpg0-tcsSMCIpJZ9OH20uckQ0c1vZIKMJrRgIR26a0G7YFXM1FoZkngwQBYu2NsTtq1oBZURpQ6gqk8DtUU7hyJ0yrcAXL--I_RpHcalGnmcGMPwmmQ";
  static const baseUrl = "https://api-sandbox.tamara.co";
  ///tamara_webhook: https://app.abnsandbox.com/api/tamara_webhook

  static Future<String?> checkOut({required Map<String,dynamic> data,required BuildContext context})async{
    try {
      if(data['shipping_address'] ==null || data['shipping_address']['line1'].toString().trim()=="" && data['billing_address']!=null){
        data['shipping_address'] = data['billing_address'];
      }
      if(data['shipping_address']['last_name']==null||data['shipping_address']['last_name']=="")data['shipping_address']['last_name']=".";
      if(data['shipping_address']['city']==null||data['shipping_address']['city']=="")data['shipping_address']['city']=data['shipping_address']['line2'];
      if(data['billing_address'] ==null || data['billing_address']['line1'].toString().trim()=="" && data['shipping_address']!=null){
        data['billing_address'] = data['shipping_address'];
      }
      if(data['billing_address']['last_name']==null||data['billing_address']['last_name']=="")data['billing_address']['last_name']=".";
      if(data['billing_address']['city']==null||data['billing_address']['city']=="")data['billing_address']['city']=data['billing_address']['line2'];
      var headers =  {
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var orderData = {
        "order_reference_id": data['order_id']??SmsApi.getRandom().toString(),
        "order_number": data['order_id']??SmsApi.getRandom().toString(),
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
          "first_name": Util.getFirstName()==""?"guest":Util.getFirstName(),
          "last_name": Util.getLastName()==""?"guest":Util.getLastName(),
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
      // debugPrint("checkOutRequest: ${response.body}");
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

  static Future<bool> authoriseOrder({required String orderID})async{
    //implemented from backend
    // try {
    //   var headers =  {
    //     "Authorization": "Bearer $tamaraApiToken",
    //     'Accept': 'application/json',
    //     'Content-Type': 'application/json',
    //   };
    //   var response = await http.post(Uri.parse("$baseUrl/orders/$orderID/authorise"),
    //     headers: headers,
    //   );
    //   debugPrint("authoriseOrder $orderID : ${response.body} ${response.request?.url}");
    //   debugPrint("res: ${response.statusCode}");
    //   if (response.statusCode == 200) {
    //     var body = json.decode(response.body);
    //     if(body['status'].toString().toLowerCase()=="authorized" || body['status'].toString().toLowerCase()=="authorised"){
    //       return true;
    //     }else{
    //       return false;
    //     }
    //   } else {
    //     return false;
    //   }
    // } catch (e) {
    //   debugPrint("retrievePayment: $e");
      return false;
    // }
  }

  static Future<double> getTamaraAmountLimit()async{
    try {
      var headers =  {
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      var response = await http.get(Uri.parse("$baseUrl/checkout/payment-types?country=sa"),
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