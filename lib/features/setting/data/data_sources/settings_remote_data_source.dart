import 'dart:convert';
import 'dart:io';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/setting/data/models/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/setting/data/models/about_us_model.dart';
import 'package:awad_nahas/features/setting/data/models/notifications_model.dart';
import 'package:awad_nahas/features/setting/data/models/privacy_model.dart';
import 'package:awad_nahas/features/setting/data/models/refund_policy_model.dart';
import 'package:awad_nahas/features/setting/data/models/terms_model.dart';

abstract class SettingsRemoteDataSourceImpl{
  Future<List<AboutUsModel>> getAboutUsData();
  Future<List<RefundPolicyModel>> getRefundPolicyData();
  Future<List<TermsModel>> getTermsData();
  Future<List<PrivacyModel>> getPrivacyData();


  /// user settings
  Future<List<NotificationsModel>> getAllNotifications();
}

class SettingsRemoteDataSource extends SettingsRemoteDataSourceImpl{
  final http.Client client;
  SettingsRemoteDataSource({required this.client});



  @override
  Future<List<NotificationsModel>> getAllNotifications() async {
    var response = await client.get(Uri.parse(ApiUrl.USER_NOTIFICATIONS),headers: ApiUrl.headerAuth);
    debugPrint("getAllNotifications ${response.body}");
    if (response.statusCode == 200) {
      return NotificationsModel.notificationListFromJson(jsonEncode(jsonDecode(response.body)['data']));
    } else {
      throw ServerException();
    }
  }


  @override
  Future<List<AboutUsModel>> getAboutUsData() {
    // TODO: implement getAboutUsData
    throw UnimplementedError();
  }

  @override
  Future<List<PrivacyModel>> getPrivacyData() {
    // TODO: implement getPrivacyData
    throw UnimplementedError();
  }

  @override
  Future<List<RefundPolicyModel>> getRefundPolicyData() {
    // TODO: implement getRefundPolicyData
    throw UnimplementedError();
  }

  @override
  Future<List<TermsModel>> getTermsData() {
    // TODO: implement getTermsData
    throw UnimplementedError();
  }

  static Future<List<LocationModel>> getOurLocations() async{
    var response = await http.get(Uri.parse(ApiUrl.OUR_LOCATIONS),headers: ApiUrl.headerAuth);
    // debugPrint("getOurLocations ${response.body}");
    var decodedData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<LocationModel> categories =
      decodedData.map<LocationModel>((categoryModel) {
        return LocationModel(
            address1: categoryModel['title']??"",
            address2: (categoryModel['address']??"").toString(),
            city: (categoryModel['city']??"").toString(),
            country: (categoryModel['country']??"").toString(),
            hours: categoryModel['hours']??[],
            lat: double.tryParse((categoryModel['lat']??"0.0").toString(),)??0,
            long:double.tryParse((categoryModel['lng']??"0.0").toString(),)??0,
          phone: categoryModel['phone'].toString(), state: '', id: 0, type: '', postCode: '', lastName: '', firstName: '', email: '',
          locationType: "",
        );
      }).toList();
      return categories;
    } else {
      throw ServerException();
    }
  }

  static Future<List<FaqsModel>> getOurFaqs() async{
    var response = await http.get(Uri.parse(ApiUrl.OUR_FAQS),headers: ApiUrl.headerAuth);
    // debugPrint("getOurFaqs ${response.body}");
    var decodedData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<FaqsModel> faqs =
      decodedData.map<FaqsModel>((model) {
        return FaqsModel(
            title: model['name'] ?? "",
            faqList: model['faq'] ==null || model['faq'].toString()=="[]" ? [] : FaqModel.listModelFromJson(jsonEncode(model['faq']))
        );
      }).toList();
      return faqs;
    } else {
      throw ServerException();
    }
  }

  static Future<bool> sendMaintenanceRequest(Map<String,dynamic> data) async{
    String imgID = await sendMaintenanceRequestImage(data['img']);
    var postData = {
      "first_name": data['first_name'] ?? "",
      "last_name": data['last_name'] ?? "",
      "city": data['city'] ?? "",
      "neighborhood": data['neighborhood'] ?? "",
      "phone_number": data['phone_number'] ?? "",
      "complaints": data['complaints'] ?? "",
      "warranty": data['warranty'] ?? "",
      "number_of_maintained_devices": (data['number_of_maintained_devices'] ?? "1").toString(),
      "product_serial": (data['product_serial'] ?? "1").toString(),
      "brand_id": (data['brand_id'] ?? "1").toString(),
      "product_type": (data['product_type'] ?? "").toString(),
      "product_model": (data['product_model'] ?? "0").toString(),
      "device_complete_2_years": (data['years_number'] ?? "1").toString(),
      'images_id': imgID,
      'lang': Util.getLang()
    };
    var response = await http.post(Uri.parse(ApiUrl.MAINTENANCE),
        body: postData);
    // debugPrint("sendMaintenanceRequest: ${response.body}");
    var decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if(decodedData['success']==true){
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  static Future<String> sendMaintenanceRequestImage(File img) async{
    var request = http.MultipartRequest("POST", Uri.parse(ApiUrl.MAINTENANCE_IMG));
    var multipartFile = await http.MultipartFile.fromPath("image", img.path);
    request.files.add(multipartFile);
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    // debugPrint("sendMaintenanceRequestImage: $respStr");
    if (response.statusCode == 200) {
    return json.decode(respStr)['data']['image_id'].toString();
    } else {
      throw ServerException();
    }
  }

  static Future<bool> sendContactUs(Map<String,dynamic> data) async{
    var response = await http.post(Uri.parse(ApiUrl.CONTACT),
        body: data);
    // debugPrint("sendContactUs: ${response.body}");
    var decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if(decodedData['success']==true){
        return true;
      }
      return false;
    } else {
      return false;
    }
  }





}