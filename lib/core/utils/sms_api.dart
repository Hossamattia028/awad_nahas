import 'dart:convert';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/send_gmail.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SmsApi{

  static Future<bool> sendOtp({required String provider,bool isEmail=true})async{
    if(isEmail){
      var otp = "${DateTime.now().millisecondsSinceEpoch.toString().substring(0,2)}${DateTime.now().millisecondsSinceEpoch.toString().substring(1,3)}";
      SharedPref().setPreferencesString(Constants.lastVerificationCode, otp);
      return await SendGmail.sendEmailMessage("This is verification code : $otp  for AwadNahas App", provider, "Verification Otp");
    }else{
      return await sendMobileOtp(phone: provider);
    }
  }

  static Future<bool> sendMobileOtp({required String phone})async{
    var otp = "${DateTime.now().millisecondsSinceEpoch.toString().substring(2,4)}${phone.substring(3,4)}${DateTime.now().microsecond.toString().substring(1,2)}";
    var response = await http.post(Uri.parse(ApiUrl.SEND_OTP),
      headers: {
        "Content-Type": "application/json",
      },body: jsonEncode({
          "otp":otp,
          "phone":phone
        })
    );
    debugPrint("sendOtp: ${response.body}");
    var decodedData = json.decode(response.body);
    var output = jsonDecode(decodedData['output']);
    if(output['statusCode']==201 || output['statusCode']==200){
      SharedPref().setPreferencesString(Constants.lastVerificationCode, otp);
      return true;
    }else{
      return false;
    }
  }

}