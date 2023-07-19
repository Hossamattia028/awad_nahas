import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentClient {

  sendPayment() async {
    String domain = "";
    var d = {"amount": "5.0", "currency": "AED", "threeDSecure": true, "save_card": false, "description":" buy products", "statement_descriptor": "Sample",
      "metadata": {"udf1": "test 1", "udf2": "test 2"},
      "reference": {"transaction": "txn_0001", "order": "ord_0001"},
      "receipt": {"email": false, "sms": true},
      "customer": {"first_name": "hossam", "middle_name": "", "last_name": "", "email": "hossam@gmail.com",
        "phone": {"country_code": "", "number": ""}},
      "merchant": {"id": "18616012"}, "source": {"id": "src_card"},
      "post": {"url": "https://awad_nahasstarsmed.com/"},
      "redirect": {"url": "https://awad_nahasstarsmed.com/"}};
    // var data = {
    //   "post": "https://awad_nahasstarsmed.com/",
    //   "redirect": "https://awad_nahasstarsmed.com/",
    //   "paymentData": {
    //     "amount": "10",
    //     "currency": "AED",
    //     "threeDSecure": true,
    //     "save_card": false,
    //     "description": "buy products",
    //     "statement_descriptor": "Sample",
    //     "metadata": const {"udf1": "test 1", "udf2": "test 2"},
    //     "reference": const{
    //       "transaction": "txn_0001",
    //       "order": "ord_0001"
    //     },
    //     "receipt": const {"email": false, "sms": true},
    //     "customer": {
    //       "first_name": SharedPref.preferences.getPreferenceString(Constants.name).toString(),
    //       "middle_name": "",
    //       "last_name": "",
    //       "email": SharedPref.preferences.getPreferenceString(Constants.email).toString(),
    //       "phone": {
    //         "country_code": "",
    //         "number": SharedPref.preferences.getPreferenceString(Constants.mobile).toString()
    //       }
    //     },
    //     "merchant": const {"id": ""},
    //     "source": const {"id": "src_card"},
    //     // "destinations": {
    //     //   "destination": [
    //     //     {"id": "480593777", "amount": 2, "currency": "KWD"},
    //     //     {"id": "486374777", "amount": 3, "currency": "KWD"}
    //     //   ]
    //     // }
    //   }
    // };
    try {
      var response = await http
          .post(Uri.parse(domain), body: jsonEncode(d), headers: {
        "Authorization": "Bearer ",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      });
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        return {'error': false, 'message': body};
      } else {
        return {
          'error': true,
          'message': "${body["errors"]?[0]?["description"]}"
        };
      }
    } catch (e) {
      // print(e);
      return {
        'error': true,
        'message': "Unable to proceed, check your internet connection."
      };
    }
  }

  Future tapPayment(BuildContext ctx,var totalPrice,VoidCallback afterSuccess)async{
   await Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const SizedBox(),
      ),
    );
  }

}
