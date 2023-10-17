
import 'dart:convert';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/data/models/user_service_model.dart';
import 'package:uuid/uuid.dart';


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
    var response = await client.get(Uri.parse(ApiUrl.USER_PROFILE_DATA),
        headers: ApiUrl.headerAuth);
    // debugPrint("getUserData: ${response.body}");
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
      if(userData['name']!=null)'user_login': Util.getUserLogin(),
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
      return const UserServiceModel(userId: 0,userLogin: '',userName: '',email: '',phoneNumber: "",);
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
      'user_login': data['user_login'],
      'password':data['password'],
    };
    var response = await client.post(Uri.parse(ApiUrl.UPDATE_USER_PASSWORD_PROFILE),body: body);
    debugPrint("changePassword: ${response.body}");
    var decodedData = json.decode(response.body);
    if (response.statusCode == 200) {
      if(decodedData['status'] && decodedData['message'].toString().contains("Successfully")){
        return AuthResponse (msg: translate("toast.update_user_data"),isSuccess: true);
      }
      //translate("login.phone_not_registered"):translate("toast.oops")
      return AuthResponse (msg: translate("toast.oops"),isFailed: true);
    } else {
      return AuthResponse (msg: translate("toast.oops"),isFailed: true);
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

  static String restApiKey = "p6132252p6:6568p7nn915no_1n0q35rs5pq892qno_16230348n7ro2o296so197q474qq02nq";
  static Future<bool> updateUserTokenForPlugin()async {
    String? token =  await FirebaseMessaging.instance.getToken();
    try{
      var response = await http.post(Uri.parse("${ApiUrl.UPDATE_USER_TOKEN_WP_PLUGIN}?rest_api_key=$restApiKey&device_uuid=${const Uuid().v4()}&device_token=${token??''}&subscription=subscription"));
      // debugPrint("updateUserTokenForPlugin: ${response.body}");
      var decodedData = json.decode(response.body);
      return decodedData['error'];
    }catch(e){
      debugPrint("updateUserTokenForPlugin: $e");
      return false;
    }
  }

  static Future<bool> updateUserToken()async {
    String? token =  await FirebaseMessaging.instance.getToken();
    try{
      var response = await http.post(
        Uri.parse(ApiUrl.UPDATE_USER_TOKEN),
        body: jsonEncode({
          "user_id": Util.getUserID(),
          "fcm_token":token ?? ""
        })
      );
      // debugPrint("updateUserToken: ${response.body}");
      var decodedData = json.decode(response.body);
      return decodedData['status'];
    }catch(e){
      debugPrint("updateUserToken: $e");
      return false;
    }
  }

}