import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/set_notification.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/data/models/user_service_model.dart';


abstract class AuthServiceRemoteDataSourceImpl {
  Future<AuthResponse> registerUser(Map<String, dynamic> userData);
  Future<AuthResponse> loginUser(Map<String, dynamic> userData);
}

class AuthServiceRemoteDataSource implements AuthServiceRemoteDataSourceImpl {
  final http.Client client;
  AuthServiceRemoteDataSource({required this.client});


  @override
  Future<AuthResponse> loginUser(Map<String, dynamic> userData) async {
    var data = {
      if(userData['phone']!=null)'user_login': userData['phone'],
      if(userData['email']!=null)'user_login': userData['email'],
      'password': userData['password'],
      // 'device_token': await Util.getCurrentUserPushToken()
    };
    var response = await client.post(
      Uri.parse(ApiUrl.LOGIN_URL),
      body: json.encode(data),
      headers: {
        "Content-Type": "application/json",
      },
    );
    var decodedData = json.decode(response.body);
    debugPrint("loginUser: ${response.body}");
    if(response.body.contains("Unauthorized")||response.body.contains("user not found")){
      return AuthResponse(user: null,msg: translate("toast.sign_wrong"));
    }else if(decodedData['status']){
      final Map<String, dynamic> bodyData = json.decode(response.body);
      UserServiceModel user = UserServiceModel.fromJson(bodyData['user']);
      await saveLocalData(bodyData);
      SetNotification.showNotification(title: "", msg: translate("toast.welcome"));
      return AuthResponse(user: user,msg: translate("toast.signup"));
    }else{
      return AuthResponse(user: null,msg: translate("toast.oops"));
    }
  }

  saveLocalData(Map<String, dynamic> bodyData)async{
    try{
      await SharedPref().setPreferencesString(Constants.userId, bodyData['user']['ID'].toString());
      await SharedPref().setPreferencesString(Constants.userId, bodyData['user']['user_login'].toString());
      ApiUrl.headerAuth = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${bodyData['access_token']}',
        'ID': '${bodyData['user']['ID']}',
      };
    }catch(e){
      debugPrint("$e");
    }
  }

  @override
  Future<AuthResponse> registerUser(Map<String, dynamic> userData,{bool social = false,File? storeBanner,File? storeLicense}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.REGISTER_URL));
      var headers = ApiUrl.headerAuth;
      // String? token =  await Util.getCurrentUserPushToken();
      request.fields['name'] = userData['name'];
      if(userData['email'] != null)request.fields['user_login'] = userData['email'];
      if(userData['phone'] != null)request.fields['user_login'] = userData['phone'];

      request.fields['password'] = userData['password'];
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      var res = await http.Response.fromStream(streamedResponse);
      debugPrint("registerUser: ${res.body}");
      var decodedData = jsonDecode(res.body);
      if(decodedData['status']){
        await saveLocalData(decodedData);
        SetNotification.showNotification(title: "", msg: translate("toast.welcome"));
        return AuthResponse(user: UserServiceModel.fromJson(decodedData['user']),msg: translate("toast.signup"));
      }else if(decodedData.toString().contains("already")){
        return  AuthResponse(user: null,msg: translate("toast.user_exist"));
      }
      return AuthResponse(user: null,msg: translate("toast.oops"));
    }catch(e){
      return AuthResponse(user: null,msg: translate("toast.oops"));
    }
  }






}