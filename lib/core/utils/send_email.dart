
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/setting/data/data_sources/settings_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SendGmail{

  /// this function use now for verification code only
  static Future<bool> sendEmailMessage({required String bodyMsg,required String userMsg,required String userEmail,required String subject}) async{
    try{
       await http.post(Uri.parse("${ApiUrl.BASE_URL}send-email-edit"),
          body: {
            "email":userEmail,
            "admin_message":bodyMsg,
            "user_message":userMsg,
            "subject":subject
          }
      );
      // debugPrint("sendGmailResponseTo $userEmail:  ${response.body}");
      // var decodedData = jsonDecode(response.body);
      // return decodedData['data']['succeeded'].toString().trim() == "1";
      return true;
    }catch(e){
      debugPrint("sendEmailMessage: $e");
      return false;
    }
  }

  static Future<bool> sendContactUs(String title,String bodyMsg,String userName,String lastName,String phone,String userEmail,String subject) async{
    try{
     return await SettingsRemoteDataSource.sendContactUs(
          {
            "first_name": userName,
            "last_name": lastName,
            "phone_number": phone,
            "email": userEmail,
            "city": Util.getCity(),
            "subject_type": subject,
            "title": title,
            "message": bodyMsg,
            'lang': Util.getLang()
          }
      );
      // String name = "$userName $lastName";
      // final response = await http.post(Uri.parse("https://api.smtp2go.com/v3/email/send"),
      //     body: jsonEncode({
      //       "api_key": "api-4D1738CA3F2D11EEA5BDF23C91BBF4A0",
      //       "to": ["AwadNahas <info@awdbadinahas.com>"],
      //       "sender": "$name <info@awdbadinahas.com>",
      //       'cc':[userEmail],
      //       "subject": subject,
      //       "text_body": "$title \n $bodyMsg",
      //       // "html_body":html,
      //       "custom_headers": [
      //         {
      //           "header": "Reply-To",
      //           "value": "Actual Person <$userEmail>"
      //         }
      //       ]
      //     })
      // );
      // debugPrint("sendGmailResponseTo $userEmail:  ${response.body}");
      // var decodedData = jsonDecode(response.body);
      // return decodedData['data']['succeeded'].toString().trim() == "1";
    }catch(e){
      debugPrint("sendEmailMessage: $e");
      return false;
    }
  }


}