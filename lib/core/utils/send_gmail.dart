import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/utils/small_fun.dart';


class SendGmail{

  /// this function use now for verification code only
  static Future sendEmailMessage(String bodyMsg,String userEmail,String subject) async{
    try{
      String messageForUser = '<h3> Hi ${Util.getName()} this is your </h3>';
      var html = ''' <img height="100px;" width="100px;"  src="" />  <br/>  $messageForUser <h1 style="color:red;"> $bodyMsg </h1>  <br/><br/><hr/>  <h4>if you have any questions please contact us <h2 style="color:black;">admin@awad_nahasstarsmed.com</h2></h4> ''';
      final response = await http.post(Uri.parse("https://api.smtp2go.com/v3/email/send"),
          body: jsonEncode({
            "api_key": "",
            "to": ["Person <$userEmail>"],
            "sender": "awad_nahasstars Medical <>",
            // "sender": "awad_nahasstars Medical <admin@awad_nahasstarsmed.com>",
            // 'cc':["awad_nahasstarsportal@gmail.com"],
            "subject": subject,
            "text_body": "",
            "html_body":html,
            "custom_headers": [
              {
                "header": "Reply-To",
                "value": "Actual Person <admin@awad_nahasstarsmed.com>"
              }
            ]
          })
      );
      debugPrint("sendGmailResponseTo $userEmail:  ${response.body}");
    }catch(e){
      debugPrint("sendEmailMessage: $e");
    }
  }


}