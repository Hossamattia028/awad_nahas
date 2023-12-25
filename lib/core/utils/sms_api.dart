import 'dart:convert';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/send_email.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class SmsApi{

  static getRandom(){
    var next = math.Random().nextDouble() * 1000;
    while (next < 1000) {
      next *= 10;
    }
    return next.toInt().toString();
  }
  static Future<bool> sendOtp({required String provider,bool isEmail=true})async{
    try{
      if(isEmail==true){
        var otp = getRandom();
        SharedPref().setPreferencesString(Constants.lastVerificationCode, otp);
        return await SendGmail.sendEmailMessage(bodyMsg: "This is verification code : $otp  for AwadNahas App",userEmail: provider, subject: "Verification Otp", );
      }else{
        return await sendMobileOtp(phone: provider);
      }
    }catch(e){
      debugPrint("sendOtpError: $e");
      return false;
    }
  }

  static Future<bool> sendMobileOtp({required String phone})async{
    var otp = getRandom();
    print(otp);
    var response = await http.post(Uri.parse(ApiUrl.SEND_OTP),
      headers: {
        "Content-Type": "application/json",
      },body: jsonEncode({
          "otp":otp,
          "phone":phone
        })
    );
    // debugPrint("sendOtp: ${response.body}");
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