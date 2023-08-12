
import 'dart:convert';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/data/models/user_service_model.dart';


abstract class UserServiceRemoteDataSourceImpl {
  Future<UserServiceModel> getUserData();
  Future<UserServiceModel> updateUserProfile({required Map<String, dynamic> userData});
  Future<AuthResponse> changePassword({required Map<String,dynamic> data});
  Future<List<UserServiceModel>> getAllUsers();
}

class UserServiceRemoteDataSource implements UserServiceRemoteDataSourceImpl {
  final http.Client client;
  UserServiceRemoteDataSource({required this.client});

  @override
  Future<UserServiceModel> getUserData() async{
    print(Util.getUserID());
    var response = await client.get(Uri.parse(ApiUrl.USER_PROFILE_DATA),
        headers: ApiUrl.headerAuth);
    debugPrint("getUserData: ${response.body}");
    var decodedData = json.decode(response.body);
    if (decodedData['status'] == true) {
      var body = json.decode(response.body);
      return UserServiceModel.fromJson(body['user']);
    } else {
      throw ServerException();
    }
  }


  @override
  Future<UserServiceModel> updateUserProfile({required Map<String, dynamic> userData}) async {
    var body = {
      if(userData['name']!=null)'user_login': userData['name']??'',
      if(userData['name']!=null)'user_nicename': userData['name']??'',
      if(userData['name']!=null)'display_name': userData['name']??'',
      if(userData['email']!=null)'user_email': userData['email'],
      if(userData['phone']!=null)'phone': userData['phone'],
    };
    // if(userData['image']!=null)await updateImg(imgPath: userData['image']);
    var response = await client.post(Uri.parse(ApiUrl.UPDATE_USER_PROFILE),
        body: json.encode(body),
        headers: ApiUrl.headerAuth);
    debugPrint("updateUserProfile: ${response.body}");
    var decodedData = jsonDecode(response.body);
    if(decodedData['status']==true){
      return UserServiceModel.fromJson(decodedData['user']);
    }else{
      return const UserServiceModel(userId: 0,userName: '',email: '',phoneNumber: "",);
    }
  }

  static Future<bool> updateImg({required String imgPath})async{
    try{
      String url = "${ApiUrl.UPDATE_USER_PROFILE}${Util.getUserID()}/profile";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var headers = ApiUrl.headerAuth;
      var file = await http.MultipartFile.fromPath('avatar', imgPath);
      request.files.add(file);
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      var res = await http.Response.fromStream(streamedResponse);
      // debugPrint("updateImg: ${res.body}");
      var decodedData = jsonDecode(res.body);
      if(decodedData['status']==true)return true;
      return false;
    }catch(e){
      debugPrint("updateImg $e");
      return false;
    }
  }

  @override
  Future<AuthResponse> changePassword({required Map<String,dynamic> data}) async{
    var body = {
      'phone':data['phone'],
      'password':data['password'],
    };
    var response = await client.post(Uri.parse(ApiUrl.UPDATE_USER_PASSWORD_PROFILE),body: body);
    debugPrint("changePassword: ${response.body}");
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return AuthResponse (msg: body['message'].toString().contains("no user")?translate("login.phone_not_registered"):translate("toast.oops"),isSuccess: body['status']);
    } else {
      return AuthResponse (msg: body['message'],isFailed: true);
    }
  }

  @override
  Future<List<UserServiceModel>> getAllUsers() async{
    List<UserServiceModel> users = [];
    var response = await client.get(Uri.parse(ApiUrl.FETCH_ALL_USER_PROFILE),
        headers: ApiUrl.headerAuth);
    debugPrint("getAllUsers: ${response.body}");
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for(var i in body['data']){
        users.add(UserServiceModel.fromJson(i));
      }
      return users;
    } else {
      throw ServerException();
    }
  }


}