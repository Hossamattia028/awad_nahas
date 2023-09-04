
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;


class TamaraSdk{
  static const tamaraApiToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhY2NvdW50SWQiOiI2ZDlmYmIyYi1jN2M0LTRiOTctOTRkMi01ZTU2MGRiY2M2OGQiLCJ0eXBlIjoibWVyY2hhbnQiLCJzYWx0IjoiNmE4MGE1MzRjZGQ2MmNlZWQ3MGYzMTZlYzIwYzAzMmEiLCJpYXQiOjE2NjYwODUyMjIsImlzcyI6IlRhbWFyYSJ9.LEp04JkR_wd0BOUOOthwpsiU4F-i8LDhGHWCt5dSmS4ieXkP1dWdUQSFZsDS4UTiYUmpqdQRIN5uVJnt6PH76BecPWoYOceT1Q9z6wvFHTev8JoS_IXZ7Op4dcg6YuBnBtD8H5Z3aNVI9TpPX5Ulgq8U6y0Na7RmHBdnYiO-K1cuHoSD8Uobp-h2GZOnyHg1PzsuklIoMIq-YIlLxcx7AehQ4jv7OWbj632rpg0-tcsSMCIpJZ9OH20uckQ0c1vZIKMJrRgIR26a0G7YFXM1FoZkngwQBYu2NsTtq1oBZURpQ6gqk8DtUU7hyJ0yrcAXL--I_RpHcalGnmcGMPwmmQ";
  static const baseUrl = "https://api-sandbox.tamara.co";

  static Future<String?> checkOut({required Map<String,dynamic> data})async{
    try {
      var headers =  {
        "Authorization": "Bearer $tamaraApiToken",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var orderData = {
        "order_reference_id": "123456",
        "order_number": "A123456",
        "total_amount": {
          "amount": data['total_price'],
          "currency": "SAR"
        },
        "description": "string",
        "country_code": "SA",
        "payment_type": "PAY_BY_INSTALMENTS",
        "instalments": null,
        "locale": "en_US",
        "items": [
          {
            "reference_id": "123456",
            "type": "Digital",
            "name": "Lego City 8601",
            "sku": "SA-12436",
            "image_url": "https://www.example.com/product.jpg",
            "item_url": "https://www.example.com/product.html",
            "quantity": 1,
            "unit_price": {
              "amount": "100.00",
              "currency": "SAR"
            },
            "discount_amount": {
              "amount": "100.00",
              "currency": "SAR"
            },
            "tax_amount": {
              "amount": "100.00",
              "currency": "SAR"
            },
            "total_amount": {
              "amount": "100.00",
              "currency": "SAR"
            }
          }
        ],
        "consumer": {
          "first_name": "Mona",
          "last_name": "Lisa",
          "phone_number": "502223333",
          "email": "user@example.com"
        },
        "billing_address": {
          "first_name": "Mona",
          "last_name": "Lisa",
          "line1": "3764 Al Urubah Rd",
          "line2": "string",
          "region": "As Sulimaniyah",
          "postal_code": "12345",
          "city": "Riyadh",
          "country_code": "SA",
          "phone_number": "502223333"
        },
        "shipping_address": {
          "first_name": "Mona",
          "last_name": "Lisa",
          "line1": "3764 Al Urubah Rd",
          "line2": "string",
          "region": "As Sulimaniyah",
          "postal_code": "12345",
          "city": "Riyadh",
          "country_code": "SA",
          "phone_number": "502223333"
        },
        "discount": {
          "name": "Christmas 2020",
          "amount": {
            "amount": "100.00",
            "currency": "SAR"
          }
        },
        "tax_amount": {
          "amount": "100.00",
          "currency": "SAR"
        },
        "shipping_amount": {
          "amount": "0.00",
          "currency": "SAR"
        },
        "merchant_url": {
          "success": "https://example.com/checkout/success",
          "failure": "https://example.com/checkout/failure",
          "cancel": "https://example.com/checkout/cancel",
          "notification": "https://example.com/payments/tamarapay"
        },
        "platform": "Magento",
        "is_mobile": false,
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