
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/setting/data/data_sources/settings_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SendGmail{

  /// this function use now for verification code only
  static Future<bool> sendEmailMessage({required String bodyMsg,required String userEmail,required String subject}) async{
    try{
      final response = await http.post(Uri.parse("${ApiUrl.BASE_URL}send-email-edit"),
          body: {
            "email":userEmail,
            "message":bodyMsg,
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
    }catch(e){
      debugPrint("sendEmailMessage: $e");
      return false;
    }
  }


}